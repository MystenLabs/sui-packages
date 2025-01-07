module 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_farm {
    struct DepositEvent has copy, drop {
        sender: address,
        lp_coin_type: 0x1::type_name::TypeName,
        lp_coin_amount: u64,
        farm_id: 0x2::object::ID,
    }

    struct WithdrawEvent has copy, drop {
        sender: address,
        lp_coin_type: 0x1::type_name::TypeName,
        lp_coin_amount: u64,
        farm_id: 0x2::object::ID,
    }

    struct RelockEvent has copy, drop {
        sender: address,
        lp_coin_type: 0x1::type_name::TypeName,
        farm_id: 0x2::object::ID,
    }

    struct HarvestEvent has copy, drop {
        sender: address,
        coin_types: vector<0x1::type_name::TypeName>,
        amounts: vector<u64>,
        farm_id: 0x2::object::ID,
    }

    public(friend) fun emit_deposit_event(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: 0x2::object::ID) {
        let v0 = DepositEvent{
            sender         : arg0,
            lp_coin_type   : arg1,
            lp_coin_amount : arg2,
            farm_id        : arg3,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public(friend) fun emit_harvest_event(arg0: address, arg1: vector<0x1::type_name::TypeName>, arg2: vector<u64>, arg3: 0x2::object::ID) {
        let v0 = HarvestEvent{
            sender     : arg0,
            coin_types : arg1,
            amounts    : arg2,
            farm_id    : arg3,
        };
        0x2::event::emit<HarvestEvent>(v0);
    }

    public(friend) fun emit_relock_event(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) {
        let v0 = RelockEvent{
            sender       : arg0,
            lp_coin_type : arg1,
            farm_id      : arg2,
        };
        0x2::event::emit<RelockEvent>(v0);
    }

    public(friend) fun emit_withdraw_event(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: 0x2::object::ID) {
        let v0 = WithdrawEvent{
            sender         : arg0,
            lp_coin_type   : arg1,
            lp_coin_amount : arg2,
            farm_id        : arg3,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

