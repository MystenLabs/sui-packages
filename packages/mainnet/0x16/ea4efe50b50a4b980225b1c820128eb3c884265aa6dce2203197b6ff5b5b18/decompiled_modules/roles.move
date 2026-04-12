module 0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::roles {
    struct MainRootCap has store, key {
        id: 0x2::object::UID,
    }

    struct RootCap has store, key {
        id: 0x2::object::UID,
    }

    struct RoleRegistry has store, key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        policy_cap_id: 0x2::object::ID,
        root_cap_id: 0x2::object::ID,
        frozen: bool,
    }

    public fun assert_admin(arg0: &RoleRegistry, arg1: &0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::admin::AdminCap) {
        assert!(0x2::object::id<0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::admin::AdminCap>(arg1) == arg0.admin_cap_id, 0);
    }

    public fun assert_not_frozen(arg0: &RoleRegistry) {
        assert!(!arg0.frozen, 3);
    }

    public fun assert_policy(arg0: &RoleRegistry, arg1: &0x2::transfer_policy::TransferPolicyCap<0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::nft::MegaTowerNFT>) {
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicyCap<0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::nft::MegaTowerNFT>>(arg1) == arg0.policy_cap_id, 1);
    }

    public fun assert_root(arg0: &RoleRegistry, arg1: &RootCap) {
        assert!(0x2::object::id<RootCap>(arg1) == arg0.root_cap_id, 2);
    }

    public(friend) fun init_main_root_cap(arg0: &mut 0x2::tx_context::TxContext) : MainRootCap {
        MainRootCap{id: 0x2::object::new(arg0)}
    }

    public(friend) fun init_role_registry(arg0: &0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::admin::AdminCap, arg1: &0x2::transfer_policy::TransferPolicyCap<0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::nft::MegaTowerNFT>, arg2: &RootCap, arg3: &mut 0x2::tx_context::TxContext) : RoleRegistry {
        RoleRegistry{
            id            : 0x2::object::new(arg3),
            admin_cap_id  : 0x2::object::id<0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::admin::AdminCap>(arg0),
            policy_cap_id : 0x2::object::id<0x2::transfer_policy::TransferPolicyCap<0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::nft::MegaTowerNFT>>(arg1),
            root_cap_id   : 0x2::object::id<RootCap>(arg2),
            frozen        : false,
        }
    }

    public(friend) fun init_root_cap(arg0: &mut 0x2::tx_context::TxContext) : RootCap {
        RootCap{id: 0x2::object::new(arg0)}
    }

    public entry fun rotate_admin(arg0: &RootCap, arg1: &mut RoleRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        assert_root(arg1, arg0);
        let v0 = 0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::admin::init_admin_cap(arg2);
        arg1.admin_cap_id = 0x2::object::id<0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::admin::AdminCap>(&v0);
        0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::admin::transfer_admin_cap(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun rotate_root(arg0: &MainRootCap, arg1: &mut RoleRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = init_root_cap(arg2);
        arg1.root_cap_id = 0x2::object::id<RootCap>(&v0);
        0x2::transfer::public_transfer<RootCap>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun set_freeze(arg0: &RootCap, arg1: &mut RoleRegistry, arg2: bool) {
        assert_root(arg1, arg0);
        arg1.frozen = arg2;
    }

    public entry fun update_policy_cap(arg0: &RootCap, arg1: &mut RoleRegistry, arg2: 0x2::transfer_policy::TransferPolicyCap<0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::nft::MegaTowerNFT>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_root(arg1, arg0);
        arg1.policy_cap_id = 0x2::object::id<0x2::transfer_policy::TransferPolicyCap<0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::nft::MegaTowerNFT>>(&arg2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x16ea4efe50b50a4b980225b1c820128eb3c884265aa6dce2203197b6ff5b5b18::nft::MegaTowerNFT>>(arg2, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

