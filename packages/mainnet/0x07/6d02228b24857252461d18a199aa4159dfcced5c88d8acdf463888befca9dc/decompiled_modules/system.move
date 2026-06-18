module 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::system {
    struct ProtocolAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PointCapIssued has copy, drop {
        project_id: 0x2::object::ID,
        point_cap_id: 0x2::object::ID,
    }

    public fun set_domain_paused(arg0: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &ProtocolAdminCap, arg2: u8, arg3: bool) {
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::set_domain_paused(arg0, arg2, arg3);
    }

    public fun set_global_paused(arg0: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &ProtocolAdminCap, arg2: bool) {
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::set_global_paused(arg0, arg2);
    }

    public fun create_global_config(arg0: &ProtocolAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig>(0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::new(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ProtocolAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun issue_point_cap(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::project_cap::ProjectCap, arg1: &mut 0x2::tx_context::TxContext) : 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap {
        let v0 = 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::new_point_cap(arg0, arg1);
        let v1 = PointCapIssued{
            project_id   : 0x2::object::id<0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::project_cap::ProjectCap>(arg0),
            point_cap_id : 0x2::object::id<0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap>(&v0),
        };
        0x2::event::emit<PointCapIssued>(v1);
        v0
    }

    public fun new_incentive_system(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &ProtocolAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::assert_domain_enabled(arg0, 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::system_domain());
        let v0 = 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::project_cap::new_project_cap(arg3);
        0x2::transfer::public_transfer<0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::project_cap::ProjectCap>(v0, arg2);
        0x2::transfer::public_transfer<0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap>(0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::new_point_cap(&v0, arg3), arg2);
    }

    public(friend) fun new_protocol_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : ProtocolAdminCap {
        ProtocolAdminCap{id: 0x2::object::new(arg0)}
    }

    public fun set_config_version(arg0: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &ProtocolAdminCap, arg2: u64) {
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::set_version(arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

