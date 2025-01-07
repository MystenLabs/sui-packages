module 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_clmm {
    struct CreatePositionEvent has copy, drop {
        sender: address,
        coin_types: vector<0x1::type_name::TypeName>,
        amounts: vector<u64>,
        pool_id: 0x2::object::ID,
    }

    struct DecreasePositionEvent has copy, drop {
        sender: address,
        coin_types: vector<0x1::type_name::TypeName>,
        amounts: vector<u64>,
        pool_id: 0x2::object::ID,
    }

    struct IncreasePositionEvent has copy, drop {
        sender: address,
        coin_types: vector<0x1::type_name::TypeName>,
        amounts: vector<u64>,
        pool_id: 0x2::object::ID,
    }

    struct ClosePositionEvent has copy, drop {
        sender: address,
        coin_types: vector<0x1::type_name::TypeName>,
        amounts: vector<u64>,
        pool_id: 0x2::object::ID,
    }

    struct HarvestPositionEvent has copy, drop {
        sender: address,
        coin_types: vector<0x1::type_name::TypeName>,
        amounts: vector<u64>,
        pool_id: 0x2::object::ID,
    }

    public(friend) fun emit_close_position_event(arg0: address, arg1: vector<0x1::type_name::TypeName>, arg2: vector<u64>, arg3: 0x2::object::ID) {
        let v0 = ClosePositionEvent{
            sender     : arg0,
            coin_types : arg1,
            amounts    : arg2,
            pool_id    : arg3,
        };
        0x2::event::emit<ClosePositionEvent>(v0);
    }

    public(friend) fun emit_create_position_event(arg0: address, arg1: vector<0x1::type_name::TypeName>, arg2: vector<u64>, arg3: 0x2::object::ID) {
        let v0 = CreatePositionEvent{
            sender     : arg0,
            coin_types : arg1,
            amounts    : arg2,
            pool_id    : arg3,
        };
        0x2::event::emit<CreatePositionEvent>(v0);
    }

    public(friend) fun emit_decrease_position_event(arg0: address, arg1: vector<0x1::type_name::TypeName>, arg2: vector<u64>, arg3: 0x2::object::ID) {
        let v0 = DecreasePositionEvent{
            sender     : arg0,
            coin_types : arg1,
            amounts    : arg2,
            pool_id    : arg3,
        };
        0x2::event::emit<DecreasePositionEvent>(v0);
    }

    public(friend) fun emit_harvest_position_event(arg0: address, arg1: vector<0x1::type_name::TypeName>, arg2: vector<u64>, arg3: 0x2::object::ID) {
        let v0 = HarvestPositionEvent{
            sender     : arg0,
            coin_types : arg1,
            amounts    : arg2,
            pool_id    : arg3,
        };
        0x2::event::emit<HarvestPositionEvent>(v0);
    }

    public(friend) fun emit_increase_position_event(arg0: address, arg1: vector<0x1::type_name::TypeName>, arg2: vector<u64>, arg3: 0x2::object::ID) {
        let v0 = IncreasePositionEvent{
            sender     : arg0,
            coin_types : arg1,
            amounts    : arg2,
            pool_id    : arg3,
        };
        0x2::event::emit<IncreasePositionEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

