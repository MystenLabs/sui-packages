module 0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::memory_rights_registry {
    struct MemoryRightsRegistry has key {
        id: 0x2::object::UID,
        owners: 0x2::table::Table<vector<u8>, address>,
        listings_sui: 0x2::table::Table<vector<u8>, u64>,
        listings_tvyn: 0x2::table::Table<vector<u8>, u64>,
    }

    struct RightsInitialized has copy, drop {
        memory_key_32: vector<u8>,
        owner: address,
    }

    struct RightsTransferred has copy, drop {
        memory_key_32: vector<u8>,
        from: address,
        to: address,
        amount: u64,
        currency: 0x1::string::String,
    }

    struct RightsListed has copy, drop {
        memory_key_32: vector<u8>,
        price: u64,
        currency: 0x1::string::String,
    }

    struct RightsDelisted has copy, drop {
        memory_key_32: vector<u8>,
    }

    public entry fun buy_rights_sui(arg0: &mut MemoryRightsRegistry, arg1: &0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::config_registry::Config, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 5);
        assert!(0x2::table::contains<vector<u8>, u64>(&arg0.listings_sui, arg2), 3);
        let v0 = *0x2::table::borrow<vector<u8>, u64>(&arg0.listings_sui, arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 >= v0, 4);
        let v2 = *0x2::table::borrow<vector<u8>, address>(&arg0.owners, arg2);
        let v3 = 0x2::tx_context::sender(arg4);
        if (v1 > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1 - v0, arg4), v3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0 * 250 / 10000, arg4), 0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::config_registry::dev_addr(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v2);
        *0x2::table::borrow_mut<vector<u8>, address>(&mut arg0.owners, arg2) = v3;
        0x2::table::remove<vector<u8>, u64>(&mut arg0.listings_sui, arg2);
        let v4 = RightsTransferred{
            memory_key_32 : arg2,
            from          : v2,
            to            : v3,
            amount        : v0,
            currency      : 0x1::string::utf8(b"SUI"),
        };
        0x2::event::emit<RightsTransferred>(v4);
    }

    public entry fun buy_rights_tvyn(arg0: &mut MemoryRightsRegistry, arg1: &0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::config_registry::Config, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::tvyn::TVYN>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 5);
        assert!(0x2::table::contains<vector<u8>, u64>(&arg0.listings_tvyn, arg2), 3);
        let v0 = *0x2::table::borrow<vector<u8>, u64>(&arg0.listings_tvyn, arg2);
        let v1 = 0x2::coin::value<0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::tvyn::TVYN>(&arg3);
        assert!(v1 >= v0, 4);
        let v2 = *0x2::table::borrow<vector<u8>, address>(&arg0.owners, arg2);
        let v3 = 0x2::tx_context::sender(arg4);
        if (v1 > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::tvyn::TVYN>>(0x2::coin::split<0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::tvyn::TVYN>(&mut arg3, v1 - v0, arg4), v3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::tvyn::TVYN>>(0x2::coin::split<0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::tvyn::TVYN>(&mut arg3, v0 * 250 / 10000, arg4), 0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::config_registry::dev_addr(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::tvyn::TVYN>>(arg3, v2);
        *0x2::table::borrow_mut<vector<u8>, address>(&mut arg0.owners, arg2) = v3;
        0x2::table::remove<vector<u8>, u64>(&mut arg0.listings_tvyn, arg2);
        let v4 = RightsTransferred{
            memory_key_32 : arg2,
            from          : v2,
            to            : v3,
            amount        : v0,
            currency      : 0x1::string::utf8(b"TVYN"),
        };
        0x2::event::emit<RightsTransferred>(v4);
    }

    public entry fun create_and_share(arg0: &0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MemoryRightsRegistry{
            id            : 0x2::object::new(arg1),
            owners        : 0x2::table::new<vector<u8>, address>(arg1),
            listings_sui  : 0x2::table::new<vector<u8>, u64>(arg1),
            listings_tvyn : 0x2::table::new<vector<u8>, u64>(arg1),
        };
        0x2::transfer::share_object<MemoryRightsRegistry>(v0);
    }

    public entry fun delist_rights(arg0: &mut MemoryRightsRegistry, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, address>(&arg0.owners, arg1), 6);
        assert!(*0x2::table::borrow<vector<u8>, address>(&arg0.owners, arg1) == 0x2::tx_context::sender(arg2), 2);
        let v0 = false;
        if (0x2::table::contains<vector<u8>, u64>(&arg0.listings_sui, arg1)) {
            0x2::table::remove<vector<u8>, u64>(&mut arg0.listings_sui, arg1);
            v0 = true;
        };
        if (0x2::table::contains<vector<u8>, u64>(&arg0.listings_tvyn, arg1)) {
            0x2::table::remove<vector<u8>, u64>(&mut arg0.listings_tvyn, arg1);
            v0 = true;
        };
        if (v0) {
            let v1 = RightsDelisted{memory_key_32: arg1};
            0x2::event::emit<RightsDelisted>(v1);
        };
    }

    public fun get_listing_price_sui(arg0: &MemoryRightsRegistry, arg1: vector<u8>) : 0x1::option::Option<u64> {
        if (0x2::table::contains<vector<u8>, u64>(&arg0.listings_sui, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<vector<u8>, u64>(&arg0.listings_sui, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_listing_price_tvyn(arg0: &MemoryRightsRegistry, arg1: vector<u8>) : 0x1::option::Option<u64> {
        if (0x2::table::contains<vector<u8>, u64>(&arg0.listings_tvyn, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<vector<u8>, u64>(&arg0.listings_tvyn, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public(friend) fun init_rights(arg0: &mut MemoryRightsRegistry, arg1: vector<u8>, arg2: address) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 5);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg0.owners, arg1), 1);
        0x2::table::add<vector<u8>, address>(&mut arg0.owners, arg1, arg2);
        if (0x2::table::contains<vector<u8>, u64>(&arg0.listings_sui, arg1)) {
            0x2::table::remove<vector<u8>, u64>(&mut arg0.listings_sui, arg1);
        };
        if (0x2::table::contains<vector<u8>, u64>(&arg0.listings_tvyn, arg1)) {
            0x2::table::remove<vector<u8>, u64>(&mut arg0.listings_tvyn, arg1);
        };
        let v0 = RightsInitialized{
            memory_key_32 : arg1,
            owner         : arg2,
        };
        0x2::event::emit<RightsInitialized>(v0);
    }

    public entry fun list_rights(arg0: &mut MemoryRightsRegistry, arg1: vector<u8>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 5);
        assert!(0x2::table::contains<vector<u8>, address>(&arg0.owners, arg1), 6);
        assert!(*0x2::table::borrow<vector<u8>, address>(&arg0.owners, arg1) == 0x2::tx_context::sender(arg4), 2);
        let v0 = if (arg3) {
            assert!(!0x2::table::contains<vector<u8>, u64>(&arg0.listings_tvyn, arg1), 7);
            if (0x2::table::contains<vector<u8>, u64>(&arg0.listings_sui, arg1)) {
                *0x2::table::borrow_mut<vector<u8>, u64>(&mut arg0.listings_sui, arg1) = arg2;
            } else {
                0x2::table::add<vector<u8>, u64>(&mut arg0.listings_sui, arg1, arg2);
            };
            0x1::string::utf8(b"SUI")
        } else {
            assert!(!0x2::table::contains<vector<u8>, u64>(&arg0.listings_sui, arg1), 7);
            if (0x2::table::contains<vector<u8>, u64>(&arg0.listings_tvyn, arg1)) {
                *0x2::table::borrow_mut<vector<u8>, u64>(&mut arg0.listings_tvyn, arg1) = arg2;
            } else {
                0x2::table::add<vector<u8>, u64>(&mut arg0.listings_tvyn, arg1, arg2);
            };
            0x1::string::utf8(b"TVYN")
        };
        let v1 = RightsListed{
            memory_key_32 : arg1,
            price         : arg2,
            currency      : v0,
        };
        0x2::event::emit<RightsListed>(v1);
    }

    public fun owner_of(arg0: &MemoryRightsRegistry, arg1: vector<u8>) : 0x1::option::Option<address> {
        if (0x2::table::contains<vector<u8>, address>(&arg0.owners, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<vector<u8>, address>(&arg0.owners, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    // decompiled from Move bytecode v6
}

