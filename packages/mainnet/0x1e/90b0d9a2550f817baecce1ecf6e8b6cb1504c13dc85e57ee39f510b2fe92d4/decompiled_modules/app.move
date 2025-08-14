module 0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::app {
    struct VeCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Acl has key {
        id: 0x2::object::UID,
    }

    struct VeCapIssuedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SetPoolAdminEvent has copy, drop, store {
        sender: address,
        pool_admin: address,
    }

    struct SetRewarderAdminEvent has copy, drop, store {
        sender: address,
        rewarder_admin: address,
    }

    public fun get_pool_admin(arg0: &Acl) : address {
        *0x2::dynamic_field::borrow<u64, address>(&arg0.id, 0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::constants::pool_admin_df_key())
    }

    public fun get_rewarder_admin(arg0: &Acl) : address {
        *0x2::dynamic_field::borrow<u64, address>(&arg0.id, 0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::constants::rewarder_admin_df_key())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Acl{id: 0x2::object::new(arg0)};
        0x2::dynamic_field::add<u64, address>(&mut v1.id, 0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::constants::rewarder_admin_df_key(), 0x2::tx_context::sender(arg0));
        0x2::dynamic_field::add<u64, address>(&mut v1.id, 0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::constants::pool_admin_df_key(), 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Acl>(v1);
    }

    public(friend) fun is_ve_cap_issued(arg0: &Acl) : bool {
        let v0 = VeCapIssuedKey{dummy_field: false};
        0x2::dynamic_field::exists_<VeCapIssuedKey>(&arg0.id, v0)
    }

    public fun issue_ve_cap(arg0: &AdminCap, arg1: &mut Acl, arg2: &mut 0x2::tx_context::TxContext) : VeCap {
        assert!(!is_ve_cap_issued(arg1), 0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::error::ve_cap_already_issued());
        set_reward_cap_issued(arg1);
        VeCap{id: 0x2::object::new(arg2)}
    }

    public fun set_pool_admin(arg0: &AdminCap, arg1: &mut Acl, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        *0x2::dynamic_field::borrow_mut<u64, address>(&mut arg1.id, 0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::constants::pool_admin_df_key()) = arg2;
        let v0 = SetPoolAdminEvent{
            sender     : 0x2::tx_context::sender(arg3),
            pool_admin : arg2,
        };
        0x2::event::emit<SetPoolAdminEvent>(v0);
    }

    fun set_reward_cap_issued(arg0: &mut Acl) {
        let v0 = VeCapIssuedKey{dummy_field: false};
        0x2::dynamic_field::add<VeCapIssuedKey, bool>(&mut arg0.id, v0, true);
    }

    public fun set_rewarder_admin(arg0: &AdminCap, arg1: &mut Acl, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        *0x2::dynamic_field::borrow_mut<u64, address>(&mut arg1.id, 0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::constants::rewarder_admin_df_key()) = arg2;
        let v0 = SetRewarderAdminEvent{
            sender         : 0x2::tx_context::sender(arg3),
            rewarder_admin : arg2,
        };
        0x2::event::emit<SetRewarderAdminEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

