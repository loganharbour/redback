[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 4
  xmax = 2
[]

[MeshModifiers]
  [./subdomain]
    type = SubdomainBoundingBox
    bottom_left = '1.0 0 0'
    block_id = 1
    top_right = '2.0 1.0 0'
  [../]
  [./interface_left]
    type = SideSetsBetweenSubdomains
    master_block = '0'
    depends_on = 'subdomain'
    new_boundary = 'interface_left'
    paired_block = '1'
  [../]
  [./interface_right]
    type = SideSetsBetweenSubdomains
    master_block = '1'
    depends_on = 'subdomain'
    new_boundary = 'interface_right'
    paired_block = '0'
  [../]
[]

[Variables]
  [./p_left]
    order = FIRST
    family = LAGRANGE
    block = '0'
  [../]
  [./p_right]
    order = FIRST
    family = LAGRANGE
    block = '1'
  [../]
[]

[Kernels]
  [./diff_left]
    type = RedbackMassDiffusion
    variable = p_left
    block = '0'
  [../]
  [./dt_left]
    type = TimeDerivative
    variable = p_left
    block = '0'
  [../]
  [./diff_right]
    type = RedbackMassDiffusion
    variable = p_right
    block = '1'
  [../]
  [./dt_right]
    type = TimeDerivative
    variable = p_right
    block = '1'
  [../]
[]

[InterfaceKernels]
  [./interface]
    type = InterfaceDarcy
    variable = p_left
    neighbor_var = 'p_right'
    boundary = 'interface_left'
    fault_lewis_number = 10
    fault_thickness = 0.1
  [../]
[]

[Materials]
  [./mat]
    type = RedbackMaterial
    ref_lewis_nb = 1
  [../]
[]

[BCs]
  [./left]
    type = DirichletBC
    variable = p_left
    boundary = 'left'
    value = 1
  [../]
  [./right]
    type = DirichletBC
    variable = p_right
    boundary = 'right'
    value = 0
  [../]
  [./middle_left]
    type = DarcyFluxBC
    variable = p_left
    boundary = interface_left
  [../]
  [./middle_right]
    type = DarcyFluxBC
    variable = p_right
    boundary = interface_right
  [../]
[]

[Postprocessors]
  [./p_left]
    type = NodalVariableValue
    nodeid = 5
    variable = p_left
  [../]
  [./p_right]
    type = NodalVariableValue
    nodeid = 5
    variable = p_right
  [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  trans_ss_check = true
[]

[Outputs]
  file_base = interfacedarcy_test
  csv = true
  execute_on = 'FINAL'
[]
