module 0x2cfdc93ead5eb39b0d10b34c39c748f132348ebd381ea093b0fd1544f47fd08::names {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        names: 0x2::table::Table<0x1::string::String, address>,
        wallets: 0x2::table::Table<address, 0x1::string::String>,
        incentives: address,
        treasury: address,
        incentive_bps: u64,
        collected_mist: u64,
        incentives_mist: u64,
        paused: bool,
    }

    struct Purchased has copy, drop {
        registry_id: 0x2::object::ID,
        buyer: address,
        name: 0x1::string::String,
        price_mist: u64,
        incentives_mist: u64,
        treasury_mist: u64,
        unallocated_mist: u64,
        incentives: address,
        treasury: address,
    }

    public fun activate_v2(arg0: &AdminCap, arg1: &mut Registry) {
        assert!(arg0.registry_id == 0x2::object::id<Registry>(arg1), 4);
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"purchase-paused-v2"), 4);
        arg1.paused = true;
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg1.id, b"purchase-paused-v2", false);
    }

    public fun collected_mist(arg0: &Registry) : u64 {
        arg0.collected_mist
    }

    public fun create(arg0: address, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(arg2 <= 10000, 4);
        assert!(arg0 != @0x0 && arg1 != @0x0, 4);
        assert!(arg2 > 0 || arg0 == arg1, 4);
        let v0 = Registry{
            id              : 0x2::object::new(arg3),
            names           : 0x2::table::new<0x1::string::String, address>(arg3),
            wallets         : 0x2::table::new<address, 0x1::string::String>(arg3),
            incentives      : arg0,
            treasury        : arg1,
            incentive_bps   : arg2,
            collected_mist  : 0,
            incentives_mist : 0,
            paused          : true,
        };
        0x2::dynamic_field::add<vector<u8>, bool>(&mut v0.id, b"purchase-paused-v2", false);
        let v1 = AdminCap{
            id          : 0x2::object::new(arg3),
            registry_id : 0x2::object::id<Registry>(&v0),
        };
        0x2::transfer::share_object<Registry>(v0);
        v1
    }

    public fun incentives_mist(arg0: &Registry) : u64 {
        arg0.incentives_mist
    }

    public fun purchase(arg0: &mut Registry, arg1: 0x1::string::String, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused, 4);
        assert!(!*0x2::dynamic_field::borrow<vector<u8>, bool>(&arg0.id, b"purchase-paused-v2"), 6);
        assert!(valid_name(&arg1), 0);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.names, arg1), 1);
        assert!(!0x2::table::contains<address, 0x1::string::String>(&arg0.wallets, 0x2::tx_context::sender(arg4)), 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 1000000000, 3);
        assert!(arg2 == arg0.incentive_bps, 5);
        let v0 = 1000000000 * arg0.incentive_bps / 10000;
        0x2::table::add<0x1::string::String, address>(&mut arg0.names, arg1, 0x2::tx_context::sender(arg4));
        0x2::table::add<address, 0x1::string::String>(&mut arg0.wallets, 0x2::tx_context::sender(arg4), arg1);
        arg0.collected_mist = arg0.collected_mist + 1000000000;
        arg0.incentives_mist = arg0.incentives_mist + v0;
        if (v0 > 0 && arg0.incentives != arg0.treasury) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0, arg4), arg0.incentives);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury);
        };
        let v1 = if (arg0.incentive_bps == 0) {
            0
        } else {
            1000000000 - v0
        };
        let v2 = if (arg0.incentive_bps == 0) {
            1000000000
        } else {
            0
        };
        let v3 = Purchased{
            registry_id      : 0x2::object::id<Registry>(arg0),
            buyer            : 0x2::tx_context::sender(arg4),
            name             : arg1,
            price_mist       : 1000000000,
            incentives_mist  : v0,
            treasury_mist    : v1,
            unallocated_mist : v2,
            incentives       : arg0.incentives,
            treasury         : arg0.treasury,
        };
        0x2::event::emit<Purchased>(v3);
    }

    public fun resolve(arg0: &Registry, arg1: 0x1::string::String) : 0x1::option::Option<address> {
        if (0x2::table::contains<0x1::string::String, address>(&arg0.names, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<0x1::string::String, address>(&arg0.names, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Registry, arg2: bool) {
        assert!(arg0.registry_id == 0x2::object::id<Registry>(arg1), 4);
        arg1.paused = true;
        *0x2::dynamic_field::borrow_mut<vector<u8>, bool>(&mut arg1.id, b"purchase-paused-v2") = arg2;
    }

    fun valid_name(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 < 3 || v1 > 32) {
            return false
        };
        let v2 = if (*0x1::vector::borrow<u8>(v0, 0) < 97) {
            true
        } else if (*0x1::vector::borrow<u8>(v0, 0) > 122) {
            true
        } else {
            *0x1::vector::borrow<u8>(v0, v1 - 1) == 45
        };
        if (v2) {
            return false
        };
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u8>(v0, v3);
            let v5 = if (v4 >= 97 && v4 <= 122) {
                true
            } else if (v4 >= 48 && v4 <= 57) {
                true
            } else {
                v4 == 45
            };
            if (!v5) {
                return false
            };
            let v6 = if (v4 == 45) {
                if (v3 > 0) {
                    *0x1::vector::borrow<u8>(v0, v3 - 1) == 45
                } else {
                    false
                }
            } else {
                false
            };
            if (v6) {
                return false
            };
            v3 = v3 + 1;
        };
        let v7 = vector[b"admin", b"support", b"official", b"suistaking", b"n1stake", b"rewards", b"claim", b"help"];
        !0x1::vector::contains<vector<u8>>(&v7, v0)
    }

    // decompiled from Move bytecode v7
}

