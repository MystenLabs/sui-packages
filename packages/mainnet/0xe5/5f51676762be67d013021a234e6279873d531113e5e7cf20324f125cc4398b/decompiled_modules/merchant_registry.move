module 0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::merchant_registry {
    struct MerchantRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        merchants: 0x2::table::Table<address, vector<u8>>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct MerchantAdded has copy, drop {
        registry_id: 0x2::object::ID,
        merchant: address,
        category: vector<u8>,
    }

    struct MerchantRemoved has copy, drop {
        registry_id: 0x2::object::ID,
        merchant: address,
    }

    public fun add_merchant(arg0: &AdminCap, arg1: &mut MerchantRegistry, arg2: address, arg3: vector<u8>) {
        assert!(arg0.registry_id == 0x2::object::id<MerchantRegistry>(arg1), 1);
        assert!(!0x2::table::contains<address, vector<u8>>(&arg1.merchants, arg2), 2);
        0x2::table::add<address, vector<u8>>(&mut arg1.merchants, arg2, arg3);
        let v0 = MerchantAdded{
            registry_id : 0x2::object::id<MerchantRegistry>(arg1),
            merchant    : arg2,
            category    : arg3,
        };
        0x2::event::emit<MerchantAdded>(v0);
    }

    public fun category_of(arg0: &MerchantRegistry, arg1: address) : vector<u8> {
        *0x2::table::borrow<address, vector<u8>>(&arg0.merchants, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MerchantRegistry{
            id        : 0x2::object::new(arg0),
            admin     : 0x2::tx_context::sender(arg0),
            merchants : 0x2::table::new<address, vector<u8>>(arg0),
        };
        let v1 = AdminCap{
            id          : 0x2::object::new(arg0),
            registry_id : 0x2::object::id<MerchantRegistry>(&v0),
        };
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<MerchantRegistry>(v0);
    }

    public fun is_registered(arg0: &MerchantRegistry, arg1: address) : bool {
        0x2::table::contains<address, vector<u8>>(&arg0.merchants, arg1)
    }

    public fun is_registered_as(arg0: &MerchantRegistry, arg1: address, arg2: &vector<u8>) : bool {
        if (!0x2::table::contains<address, vector<u8>>(&arg0.merchants, arg1)) {
            return false
        };
        0x2::table::borrow<address, vector<u8>>(&arg0.merchants, arg1) == arg2
    }

    public fun remove_merchant(arg0: &AdminCap, arg1: &mut MerchantRegistry, arg2: address) {
        assert!(arg0.registry_id == 0x2::object::id<MerchantRegistry>(arg1), 1);
        assert!(0x2::table::contains<address, vector<u8>>(&arg1.merchants, arg2), 3);
        0x2::table::remove<address, vector<u8>>(&mut arg1.merchants, arg2);
        let v0 = MerchantRemoved{
            registry_id : 0x2::object::id<MerchantRegistry>(arg1),
            merchant    : arg2,
        };
        0x2::event::emit<MerchantRemoved>(v0);
    }

    // decompiled from Move bytecode v7
}

