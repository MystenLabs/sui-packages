module 0x113d11f49e7b9e9b2cd872ae9523cf7d3b1333e6f3ebd11800ee70f6ef6e5f3b::kyc_registry_mock {
    struct KYCRegistry has key {
        id: 0x2::object::UID,
        allowed: 0x2::table::Table<address, bool>,
        managers: vector<address>,
    }

    struct KYCRegistryOwner has key {
        id: 0x2::object::UID,
    }

    struct Added has copy, drop {
        user: address,
        status: bool,
    }

    struct NewManager has copy, drop {
        manager: address,
    }

    struct RevokeManager has copy, drop {
        manager: address,
    }

    public fun change_owner(arg0: KYCRegistryOwner, arg1: address) {
        0x2::transfer::transfer<KYCRegistryOwner>(arg0, arg1);
    }

    public fun create_kyc(arg0: &KYCRegistryOwner, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg1);
        let v1 = KYCRegistry{
            id       : v0,
            allowed  : 0x2::table::new<address, bool>(arg1),
            managers : 0x1::vector::singleton<address>(0x2::tx_context::sender(arg1)),
        };
        0x2::transfer::share_object<KYCRegistry>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public entry fun get_status(arg0: &KYCRegistry, arg1: address) : bool {
        *0x2::table::borrow<address, bool>(&arg0.allowed, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KYCRegistryOwner{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<KYCRegistryOwner>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun revoke_managers(arg0: &KYCRegistryOwner, arg1: &mut KYCRegistry, arg2: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            let (v2, v3) = 0x1::vector::index_of<address>(&arg1.managers, &v1);
            assert!(v2, 2);
            0x1::vector::remove<address>(&mut arg1.managers, v3);
            let v4 = RevokeManager{manager: v1};
            0x2::event::emit<RevokeManager>(v4);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public entry fun set_accept_status(arg0: &mut KYCRegistry, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.managers, &v0), 0);
        if (!0x2::table::contains<address, bool>(&arg0.allowed, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.allowed, arg1, arg2);
        } else {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.allowed, arg1) = arg2;
        };
        let v1 = Added{
            user   : arg1,
            status : arg2,
        };
        0x2::event::emit<Added>(v1);
    }

    public entry fun set_accept_statuses(arg0: &mut KYCRegistry, arg1: vector<address>, arg2: vector<bool>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.managers, &v0), 0);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<bool>(&arg2), 3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            set_accept_status(arg0, 0x1::vector::pop_back<address>(&mut arg1), 0x1::vector::pop_back<bool>(&mut arg2), arg3);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<address>(arg1);
        0x1::vector::destroy_empty<bool>(arg2);
    }

    public entry fun set_managers(arg0: &KYCRegistryOwner, arg1: &mut KYCRegistry, arg2: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            assert!(!0x1::vector::contains<address>(&arg1.managers, &v1), 1);
            0x1::vector::push_back<address>(&mut arg1.managers, v1);
            let v2 = NewManager{manager: v1};
            0x2::event::emit<NewManager>(v2);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    // decompiled from Move bytecode v6
}

