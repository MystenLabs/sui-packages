module 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::system {
    struct ProtocolAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PointCapIssued has copy, drop {
        project_id: 0x2::object::ID,
        point_cap_id: 0x2::object::ID,
    }

    public fun set_domain_paused(arg0: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &ProtocolAdminCap, arg2: u8, arg3: bool) {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::set_domain_paused(arg0, arg2, arg3);
    }

    public fun set_global_paused(arg0: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &ProtocolAdminCap, arg2: bool) {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::set_global_paused(arg0, arg2);
    }

    public fun allow_config_version(arg0: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &ProtocolAdminCap, arg2: u64) {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::allow_version(arg0, arg2);
    }

    public fun disallow_config_version(arg0: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &ProtocolAdminCap, arg2: u64) {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::disallow_version(arg0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ProtocolAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun issue_point_cap(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_cap::ProjectCap, arg1: &mut 0x2::tx_context::TxContext) : 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_cap::PointCap {
        let v0 = 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_cap::new_point_cap(arg0, arg1);
        let v1 = PointCapIssued{
            project_id   : 0x2::object::id<0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_cap::ProjectCap>(arg0),
            point_cap_id : 0x2::object::id<0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_cap::PointCap>(&v0),
        };
        0x2::event::emit<PointCapIssued>(v1);
        v0
    }

    public fun new_incentive_system(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &ProtocolAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::system_domain());
        let v0 = 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_cap::new_project_cap(arg3);
        0x2::transfer::public_transfer<0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_cap::ProjectCap>(v0, arg2);
        0x2::transfer::public_transfer<0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_cap::PointCap>(0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_cap::new_point_cap(&v0, arg3), arg2);
    }

    public(friend) fun new_protocol_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : ProtocolAdminCap {
        ProtocolAdminCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v7
}

