module 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest {
    struct InterestTable has store, key {
        id: 0x2::object::UID,
        interest_rate: u256,
        active_interest_index: u256,
        last_active_index_update: u64,
        interest_payable: u256,
    }

    struct BottleInterestIndex has store, key {
        id: 0x2::object::UID,
        active_interest_index: u256,
    }

    public(friend) fun accrue_active_interests(arg0: &mut InterestTable, arg1: u64, arg2: &0x2::clock::Clock) : (u256, u256) {
        let (v0, v1) = calculate_interest_index(arg0, arg2);
        let v2 = 0;
        if (v1 > 0) {
            let v3 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::math::mul_factor_u256((arg1 as u256), v1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::interest_precision());
            v2 = v3;
            arg0.interest_payable = arg0.interest_payable + v3;
            arg0.active_interest_index = v0;
            arg0.last_active_index_update = 0x2::clock::timestamp_ms(arg2);
        };
        (v0, v2)
    }

    public(friend) fun calculate_interest_index(arg0: &InterestTable, arg1: &0x2::clock::Clock) : (u256, u256) {
        let v0 = arg0.last_active_index_update;
        assert!(0x2::clock::timestamp_ms(arg1) >= v0, 1);
        if (0x2::clock::timestamp_ms(arg1) == v0) {
            return (arg0.active_interest_index, 0)
        };
        let v1 = arg0.interest_rate;
        let v2 = arg0.active_interest_index;
        let v3 = v2;
        let v4 = 0;
        if (v1 > 0) {
            let v5 = ((0x2::clock::timestamp_ms(arg1) - v0) as u256) * v1;
            v4 = v5;
            v3 = v2 + 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::math::mul_factor_u256(v2, v5, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::interest_precision());
        };
        (v3, v4)
    }

    public(friend) fun collect_interests(arg0: &mut InterestTable) : u64 {
        let v0 = arg0.interest_payable;
        arg0.interest_payable = 0;
        assert!(v0 <= (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::max_u64() as u256), 0);
        (v0 as u64)
    }

    public fun get_active_interest_index(arg0: &InterestTable) : u256 {
        arg0.active_interest_index
    }

    public fun get_bottle_interest_index(arg0: &BottleInterestIndex) : u256 {
        arg0.active_interest_index
    }

    public fun get_interest_payable(arg0: &InterestTable) : u256 {
        arg0.interest_payable
    }

    public fun get_interest_rate(arg0: &InterestTable) : u256 {
        arg0.interest_rate
    }

    public fun get_interest_table_info(arg0: &InterestTable) : (u256, u256, u64, u256) {
        (arg0.interest_rate, arg0.active_interest_index, arg0.last_active_index_update, arg0.interest_payable)
    }

    public fun get_last_active_index_update(arg0: &InterestTable) : u64 {
        arg0.last_active_index_update
    }

    public(friend) fun new_bottle_interest_index(arg0: u256, arg1: &mut 0x2::tx_context::TxContext) : BottleInterestIndex {
        BottleInterestIndex{
            id                    : 0x2::object::new(arg1),
            active_interest_index : arg0,
        }
    }

    public(friend) fun new_interest_table(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : InterestTable {
        InterestTable{
            id                       : 0x2::object::new(arg1),
            interest_rate            : 0,
            active_interest_index    : 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::interest_precision(),
            last_active_index_update : 0x2::clock::timestamp_ms(arg0),
            interest_payable         : 0,
        }
    }

    public(friend) fun set_interest_rate(arg0: &mut InterestTable, arg1: u256, arg2: u64, arg3: &0x2::clock::Clock) {
        if (arg1 != arg0.interest_rate) {
            let (_, _) = accrue_active_interests(arg0, arg2, arg3);
            arg0.last_active_index_update = 0x2::clock::timestamp_ms(arg3);
            arg0.interest_rate = arg1;
        };
    }

    public(friend) fun update_bottle_interest_index(arg0: &mut BottleInterestIndex, arg1: u256) {
        if (arg0.active_interest_index < arg1) {
            arg0.active_interest_index = arg1;
        };
    }

    // decompiled from Move bytecode v6
}

