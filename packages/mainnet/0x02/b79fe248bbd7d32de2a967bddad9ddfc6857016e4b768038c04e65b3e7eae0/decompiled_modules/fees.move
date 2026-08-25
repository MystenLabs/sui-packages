module 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees {
    struct FeeVault has key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        creator_of: 0x2::table::Table<0x2::object::ID, address>,
        creator_unclaimed: 0x2::table::Table<0x2::object::ID, u64>,
        creator_lifetime: 0x2::table::Table<0x2::object::ID, u64>,
        referrer_unclaimed: 0x2::table::Table<address, u64>,
        referrer_lifetime: 0x2::table::Table<address, u64>,
        protocol_unclaimed: u64,
        protocol_lifetime: u64,
        total_fees: u64,
    }

    public fun balance(arg0: &FeeVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds)
    }

    public(friend) fun accrue(arg0: &mut FeeVault, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x1::option::Option<address>) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg2);
            return
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, arg2);
        arg0.total_fees = arg0.total_fees + v0;
        let v1 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::mul_bps(v0, 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::creator_bps());
        let v2 = if (0x1::option::is_some<address>(&arg3)) {
            0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::mul_bps(v0, 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::referrer_bps())
        } else {
            0
        };
        let v3 = v0 - v1 - v2;
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.creator_unclaimed, arg1)) {
            let v4 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.creator_unclaimed, arg1);
            *v4 = *v4 + v1;
            let v5 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.creator_lifetime, arg1);
            *v5 = *v5 + v1;
        } else {
            arg0.protocol_unclaimed = arg0.protocol_unclaimed + v1;
            arg0.protocol_lifetime = arg0.protocol_lifetime + v1;
        };
        if (v2 > 0) {
            let v6 = *0x1::option::borrow<address>(&arg3);
            if (0x2::table::contains<address, u64>(&arg0.referrer_unclaimed, v6)) {
                let v7 = 0x2::table::borrow_mut<address, u64>(&mut arg0.referrer_unclaimed, v6);
                *v7 = *v7 + v2;
                let v8 = 0x2::table::borrow_mut<address, u64>(&mut arg0.referrer_lifetime, v6);
                *v8 = *v8 + v2;
            } else {
                0x2::table::add<address, u64>(&mut arg0.referrer_unclaimed, v6, v2);
                0x2::table::add<address, u64>(&mut arg0.referrer_lifetime, v6, v2);
            };
        };
        arg0.protocol_unclaimed = arg0.protocol_unclaimed + v3;
        arg0.protocol_lifetime = arg0.protocol_lifetime + v3;
    }

    public fun claim_creator(arg0: &mut FeeVault, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<0x2::object::ID, address>(&arg0.creator_of, arg1), 2);
        assert!(*0x2::table::borrow<0x2::object::ID, address>(&arg0.creator_of, arg1) == v0, 0);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.creator_unclaimed, arg1);
        let v2 = *v1;
        assert!(v2 > 0, 1);
        *v1 = 0;
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::fees_claimed(v0, 0x1::ascii::string(b"creator"), 0x1::option::some<0x2::object::ID>(arg1), v2, 0x2::clock::timestamp_ms(arg2));
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, v2, arg3)
    }

    public fun claim_creator_many(arg0: &mut FeeVault, arg1: vector<0x2::object::ID>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v2);
            if (0x2::table::contains<0x2::object::ID, address>(&arg0.creator_of, v3) && *0x2::table::borrow<0x2::object::ID, address>(&arg0.creator_of, v3) == v0) {
                let v4 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.creator_unclaimed, v3);
                let v5 = *v4;
                if (v5 > 0) {
                    *v4 = 0;
                    0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.funds, v5));
                    0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::fees_claimed(v0, 0x1::ascii::string(b"creator"), 0x1::option::some<0x2::object::ID>(v3), v5, 0x2::clock::timestamp_ms(arg2));
                };
            };
            v2 = v2 + 1;
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1) > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3), v0);
    }

    public fun claim_creator_to_sender(arg0: &mut FeeVault, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_creator(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun claim_protocol(arg0: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::AdminCap, arg1: &mut FeeVault, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.protocol_unclaimed;
        assert!(v0 > 0, 1);
        arg1.protocol_unclaimed = 0;
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::fees_claimed(arg2, 0x1::ascii::string(b"protocol"), 0x1::option::none<0x2::object::ID>(), v0, 0x2::clock::timestamp_ms(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.funds, v0, arg4), arg2);
    }

    public fun claim_referrer(arg0: &mut FeeVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.referrer_unclaimed, v0), 1);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.referrer_unclaimed, v0);
        let v2 = *v1;
        assert!(v2 > 0, 1);
        *v1 = 0;
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::fees_claimed(v0, 0x1::ascii::string(b"referrer"), 0x1::option::none<0x2::object::ID>(), v2, 0x2::clock::timestamp_ms(arg1));
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, v2, arg2)
    }

    public fun claim_referrer_to_sender(arg0: &mut FeeVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_referrer(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun creator_lifetime(arg0: &FeeVault, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.creator_lifetime, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.creator_lifetime, arg1)
        } else {
            0
        }
    }

    public fun creator_of(arg0: &FeeVault, arg1: 0x2::object::ID) : address {
        *0x2::table::borrow<0x2::object::ID, address>(&arg0.creator_of, arg1)
    }

    public fun creator_unclaimed(arg0: &FeeVault, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.creator_unclaimed, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.creator_unclaimed, arg1)
        } else {
            0
        }
    }

    public fun deposit_external(arg0: &mut FeeVault, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x1::option::Option<address>) {
        accrue(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeVault{
            id                 : 0x2::object::new(arg0),
            funds              : 0x2::balance::zero<0x2::sui::SUI>(),
            creator_of         : 0x2::table::new<0x2::object::ID, address>(arg0),
            creator_unclaimed  : 0x2::table::new<0x2::object::ID, u64>(arg0),
            creator_lifetime   : 0x2::table::new<0x2::object::ID, u64>(arg0),
            referrer_unclaimed : 0x2::table::new<address, u64>(arg0),
            referrer_lifetime  : 0x2::table::new<address, u64>(arg0),
            protocol_unclaimed : 0,
            protocol_lifetime  : 0,
            total_fees         : 0,
        };
        0x2::transfer::share_object<FeeVault>(v0);
    }

    public fun preview_split(arg0: u64, arg1: bool) : (u64, u64, u64) {
        let v0 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::mul_bps(arg0, 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::creator_bps());
        let v1 = if (arg1) {
            0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::mul_bps(arg0, 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::referrer_bps())
        } else {
            0
        };
        (v0, v1, arg0 - v0 - v1)
    }

    public fun protocol_lifetime(arg0: &FeeVault) : u64 {
        arg0.protocol_lifetime
    }

    public fun protocol_unclaimed(arg0: &FeeVault) : u64 {
        arg0.protocol_unclaimed
    }

    public fun referrer_lifetime(arg0: &FeeVault, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.referrer_lifetime, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.referrer_lifetime, arg1)
        } else {
            0
        }
    }

    public fun referrer_unclaimed(arg0: &FeeVault, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.referrer_unclaimed, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.referrer_unclaimed, arg1)
        } else {
            0
        }
    }

    public(friend) fun register_curve(arg0: &mut FeeVault, arg1: 0x2::object::ID, arg2: address) {
        0x2::table::add<0x2::object::ID, address>(&mut arg0.creator_of, arg1, arg2);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.creator_unclaimed, arg1, 0);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.creator_lifetime, arg1, 0);
    }

    public fun total_fees(arg0: &FeeVault) : u64 {
        arg0.total_fees
    }

    // decompiled from Move bytecode v7
}

