module 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events {
    struct BottleCreated has copy, drop {
        collateral_type: 0x1::ascii::String,
        debtor: address,
        bottle_id: 0x2::object::ID,
        collateral_amount: u64,
        buck_amount: u64,
    }

    struct BottleUpdated has copy, drop {
        collateral_type: 0x1::ascii::String,
        debtor: address,
        bottle_id: 0x2::object::ID,
        collateral_amount: u64,
        buck_amount: u64,
    }

    struct BottleDestroyed has copy, drop {
        collateral_type: 0x1::ascii::String,
        debtor: address,
        bottle_id: 0x2::object::ID,
    }

    struct SurplusBottleGenerated has copy, drop {
        collateral_type: 0x1::ascii::String,
        debtor: address,
        bottle_id: 0x2::object::ID,
        collateral_amount: u64,
    }

    struct SurplusBottleWithdrawal has copy, drop {
        collateral_type: 0x1::ascii::String,
        debtor: address,
        bottle_id: 0x2::object::ID,
    }

    struct Redeem has copy, drop {
        collateral_type: 0x1::ascii::String,
        input_buck_amount: u64,
        output_collateral_amount: u64,
    }

    struct FeeRateChanged has copy, drop {
        collateral_type: 0x1::ascii::String,
        base_fee_rate: u64,
    }

    struct Redistribution has copy, drop {
        collateral_type: 0x1::ascii::String,
    }

    public(friend) fun emit_bottle_created<T0>(arg0: address, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle) {
        let (v0, v1) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_raw_info(arg1);
        let v2 = BottleCreated{
            collateral_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            debtor            : arg0,
            bottle_id         : *0x2::object::borrow_id<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(arg1),
            collateral_amount : v0,
            buck_amount       : v1,
        };
        0x2::event::emit<BottleCreated>(v2);
    }

    public(friend) fun emit_bottle_destroyed<T0>(arg0: address, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle) {
        let v0 = BottleDestroyed{
            collateral_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            debtor          : arg0,
            bottle_id       : *0x2::object::borrow_id<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(arg1),
        };
        0x2::event::emit<BottleDestroyed>(v0);
    }

    public(friend) fun emit_bottle_updated<T0>(arg0: address, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle) {
        let (v0, v1) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_raw_info(arg1);
        let v2 = BottleUpdated{
            collateral_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            debtor            : arg0,
            bottle_id         : *0x2::object::borrow_id<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(arg1),
            collateral_amount : v0,
            buck_amount       : v1,
        };
        0x2::event::emit<BottleUpdated>(v2);
    }

    public(friend) fun emit_fee_rate_changed<T0>(arg0: u64) {
        let v0 = FeeRateChanged{
            collateral_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            base_fee_rate   : arg0,
        };
        0x2::event::emit<FeeRateChanged>(v0);
    }

    public(friend) fun emit_redeem<T0>(arg0: u64, arg1: u64) {
        let v0 = Redeem{
            collateral_type          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            input_buck_amount        : arg0,
            output_collateral_amount : arg1,
        };
        0x2::event::emit<Redeem>(v0);
    }

    public(friend) fun emit_redistribution<T0>() {
        let v0 = Redistribution{collateral_type: 0x1::type_name::into_string(0x1::type_name::get<T0>())};
        0x2::event::emit<Redistribution>(v0);
    }

    public(friend) fun emit_surplus_bottle_generated<T0>(arg0: address, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle) {
        let (v0, _) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_raw_info(arg1);
        let v2 = SurplusBottleGenerated{
            collateral_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            debtor            : arg0,
            bottle_id         : *0x2::object::borrow_id<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(arg1),
            collateral_amount : v0,
        };
        0x2::event::emit<SurplusBottleGenerated>(v2);
    }

    public(friend) fun emit_surplus_bottle_withdrawal<T0>(arg0: address, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle) {
        let v0 = SurplusBottleWithdrawal{
            collateral_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            debtor          : arg0,
            bottle_id       : *0x2::object::borrow_id<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(arg1),
        };
        0x2::event::emit<SurplusBottleWithdrawal>(v0);
    }

    // decompiled from Move bytecode v6
}

