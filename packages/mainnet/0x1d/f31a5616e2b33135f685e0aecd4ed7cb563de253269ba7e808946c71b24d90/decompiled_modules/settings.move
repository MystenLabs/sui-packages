module 0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::settings {
    struct WorkspaceSettings has store {
        name: 0x1::string::String,
        is_operational: bool,
        is_paused: bool,
        admin_pause_cap_id: 0x1::option::Option<0x2::object::ID>,
        allowed_tx_effect_module_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        allowed_tx_assemble_module_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        tx_effect_module_groups: 0x2::vec_map::VecMap<u16, ActionGroup>,
        workspace_cap: 0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::workspace_registry::WorkspaceCap,
        id_counter: u16,
    }

    struct ActionGroup has store {
        name: 0x1::string::String,
        ids: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct OffchainBackupEvent has copy, drop {
        workspace_id: 0x2::object::ID,
        public_keys: vector<vector<u8>>,
        info: 0x1::string::String,
    }

    struct RevokeOffchainBackupEvent has copy, drop {
        workspace_id: 0x2::object::ID,
    }

    public(friend) fun borrow_workspace_cap(arg0: &WorkspaceSettings) : &0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::workspace_registry::WorkspaceCap {
        &arg0.workspace_cap
    }

    public(friend) fun eject_approve_caps(arg0: &mut WorkspaceSettings, arg1: 0x2::object::ID, arg2: vector<0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::approve_interface::ApproveCap>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.is_operational = false;
        0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::workspace_registry::eject(&arg0.workspace_cap, arg1, arg3, arg2, arg4);
    }

    public(friend) fun execute_config_add_action_modules(arg0: &mut WorkspaceSettings, arg1: vector<0x2::object::ID>, arg2: vector<0x2::object::ID>) {
        0x1::vector::reverse<0x2::object::ID>(&mut arg1);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg1)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_tx_effect_module_ids, 0x1::vector::pop_back<0x2::object::ID>(&mut arg1));
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg1);
        0x1::vector::reverse<0x2::object::ID>(&mut arg2);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg2)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_tx_assemble_module_ids, 0x1::vector::pop_back<0x2::object::ID>(&mut arg2));
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg2);
    }

    public(friend) fun execute_config_create_action_group(arg0: &mut WorkspaceSettings, arg1: 0x1::string::String) {
        let v0 = ActionGroup{
            name : arg1,
            ids  : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        arg0.id_counter = arg0.id_counter + 1;
        0x2::vec_map::insert<u16, ActionGroup>(&mut arg0.tx_effect_module_groups, arg0.id_counter, v0);
    }

    public(friend) fun execute_config_delete_action_group(arg0: &mut WorkspaceSettings, arg1: u16) {
        let (_, v1) = 0x2::vec_map::remove<u16, ActionGroup>(&mut arg0.tx_effect_module_groups, &arg1);
        let ActionGroup {
            name : _,
            ids  : v3,
        } = v1;
        let v4 = v3;
        assert!(0x2::vec_set::size<0x2::object::ID>(&v4) == 0, 3);
    }

    public(friend) fun execute_config_edit_action_group(arg0: &mut WorkspaceSettings, arg1: 0x1::option::Option<u16>, arg2: &mut 0x1::option::Option<0x1::string::String>, arg3: vector<0x2::object::ID>, arg4: vector<0x2::object::ID>) {
        let v0 = 0x1::option::destroy_with_default<u16>(arg1, arg0.id_counter - 1);
        let v1 = 0x2::vec_map::get_mut<u16, ActionGroup>(&mut arg0.tx_effect_module_groups, &v0);
        if (0x1::option::is_some<0x1::string::String>(arg2)) {
            v1.name = 0x1::option::extract<0x1::string::String>(arg2);
        };
        0x1::vector::reverse<0x2::object::ID>(&mut arg3);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg3)) {
            let v2 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg3);
            assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_tx_effect_module_ids, &v2), 2);
            0x2::vec_set::insert<0x2::object::ID>(&mut v1.ids, v2);
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg3);
        0x1::vector::reverse<0x2::object::ID>(&mut arg4);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg4)) {
            let v3 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg4);
            0x2::vec_set::remove<0x2::object::ID>(&mut v1.ids, &v3);
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg4);
    }

    public(friend) fun execute_config_edit_workspace_name(arg0: &mut WorkspaceSettings, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    public(friend) fun execute_config_offchain_backup(arg0: 0x2::object::ID, arg1: vector<vector<u8>>, arg2: 0x1::string::String) {
        let v0 = OffchainBackupEvent{
            workspace_id : arg0,
            public_keys  : arg1,
            info         : arg2,
        };
        0x2::event::emit<OffchainBackupEvent>(v0);
    }

    public(friend) fun execute_config_remove_action_modules(arg0: &mut WorkspaceSettings, arg1: vector<0x2::object::ID>, arg2: vector<0x2::object::ID>) {
        0x1::vector::reverse<0x2::object::ID>(&mut arg1);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg1)) {
            let v0 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg1);
            let v1 = get_group_ids_by_action_id(arg0, v0);
            assert!(0x1::vector::is_empty<u16>(&v1), 1);
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_tx_effect_module_ids, &v0);
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg1);
        0x1::vector::reverse<0x2::object::ID>(&mut arg2);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg2)) {
            let v2 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg2);
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_tx_assemble_module_ids, &v2);
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg2);
    }

    public(friend) fun execute_config_revoke_offchain_backup(arg0: 0x2::object::ID) {
        let v0 = RevokeOffchainBackupEvent{workspace_id: arg0};
        0x2::event::emit<RevokeOffchainBackupEvent>(v0);
    }

    public(friend) fun execute_config_trigger_pause_workspace(arg0: &mut WorkspaceSettings) {
        arg0.is_paused = !arg0.is_paused;
    }

    public(friend) fun execute_config_unpause_workspace(arg0: &mut WorkspaceSettings) {
        assert!(arg0.is_paused, 4);
        arg0.is_paused = false;
    }

    public fun get_action_group_fields(arg0: &ActionGroup) : (0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>) {
        (arg0.name, arg0.ids)
    }

    public(friend) fun get_admin_pause_cap_id(arg0: &WorkspaceSettings) : 0x1::option::Option<0x2::object::ID> {
        arg0.admin_pause_cap_id
    }

    public(friend) fun get_group_ids_by_action_id(arg0: &WorkspaceSettings, arg1: 0x2::object::ID) : vector<u16> {
        let v0 = 0x1::vector::empty<u16>();
        let v1 = 0x2::vec_map::keys<u16, ActionGroup>(&arg0.tx_effect_module_groups);
        0x1::vector::reverse<u16>(&mut v1);
        while (!0x1::vector::is_empty<u16>(&v1)) {
            let v2 = 0x1::vector::pop_back<u16>(&mut v1);
            if (0x2::vec_set::contains<0x2::object::ID>(&0x2::vec_map::get<u16, ActionGroup>(&arg0.tx_effect_module_groups, &v2).ids, &arg1)) {
                0x1::vector::push_back<u16>(&mut v0, v2);
            };
        };
        0x1::vector::destroy_empty<u16>(v1);
        v0
    }

    public(friend) fun get_next_id(arg0: &WorkspaceSettings) : u16 {
        arg0.id_counter
    }

    public(friend) fun get_settings_fields(arg0: &WorkspaceSettings) : (0x1::string::String, bool, 0x2::vec_set::VecSet<0x2::object::ID>, 0x2::vec_set::VecSet<0x2::object::ID>, &0x2::vec_map::VecMap<u16, ActionGroup>, &0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::workspace_registry::WorkspaceCap, u16) {
        (arg0.name, arg0.is_operational, arg0.allowed_tx_effect_module_ids, arg0.allowed_tx_assemble_module_ids, &arg0.tx_effect_module_groups, &arg0.workspace_cap, arg0.id_counter)
    }

    public fun get_workspace_settings_fields(arg0: &WorkspaceSettings) : (0x1::string::String, bool, bool, 0x1::option::Option<0x2::object::ID>, 0x2::vec_set::VecSet<0x2::object::ID>, 0x2::vec_set::VecSet<0x2::object::ID>, 0x2::object::ID, &0x2::vec_map::VecMap<u16, ActionGroup>, u16) {
        (arg0.name, arg0.is_operational, arg0.is_paused, arg0.admin_pause_cap_id, arg0.allowed_tx_effect_module_ids, arg0.allowed_tx_assemble_module_ids, 0x2::object::id<0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::workspace_registry::WorkspaceCap>(&arg0.workspace_cap), &arg0.tx_effect_module_groups, arg0.id_counter)
    }

    public(friend) fun init_workspace_settings(arg0: 0x1::string::String, arg1: 0x1::option::Option<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) : WorkspaceSettings {
        WorkspaceSettings{
            name                           : arg0,
            is_operational                 : true,
            is_paused                      : false,
            admin_pause_cap_id             : arg1,
            allowed_tx_effect_module_ids   : 0x2::vec_set::empty<0x2::object::ID>(),
            allowed_tx_assemble_module_ids : 0x2::vec_set::empty<0x2::object::ID>(),
            tx_effect_module_groups        : 0x2::vec_map::empty<u16, ActionGroup>(),
            workspace_cap                  : 0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::workspace_registry::create_workspace_cap(arg2),
            id_counter                     : 0,
        }
    }

    public(friend) fun is_action_group_valid(arg0: &WorkspaceSettings, arg1: u16) : bool {
        0x2::vec_map::contains<u16, ActionGroup>(&arg0.tx_effect_module_groups, &arg1)
    }

    public(friend) fun is_action_valid(arg0: &WorkspaceSettings, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_tx_effect_module_ids, &arg1)
    }

    public(friend) fun is_assemble_module_allowed(arg0: &WorkspaceSettings, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_tx_assemble_module_ids, &arg1)
    }

    public(friend) fun is_effect_module_allowed(arg0: &WorkspaceSettings, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_tx_effect_module_ids, &arg1)
    }

    public(friend) fun is_operational(arg0: &WorkspaceSettings) : bool {
        arg0.is_operational
    }

    public(friend) fun is_paused(arg0: &WorkspaceSettings) : bool {
        arg0.is_paused
    }

    public(friend) fun set_operational(arg0: &mut WorkspaceSettings) {
        assert!(!arg0.is_operational, 0);
        arg0.is_operational = true;
    }

    // decompiled from Move bytecode v6
}

