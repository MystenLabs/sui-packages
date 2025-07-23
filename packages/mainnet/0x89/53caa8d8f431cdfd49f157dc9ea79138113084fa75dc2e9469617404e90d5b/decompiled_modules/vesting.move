module 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vesting {
    struct VestingSchedule<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        beneficiary: address,
        total_amount: u64,
        claimed_amount: u64,
        start_time: u64,
        vesting_duration: u64,
        time_unit: u8,
        release_per_minute: u64,
        last_claim_time: u64,
        partial_claim_count: u64,
        time_extension_factor: u64,
    }

    struct VestingCreated has copy, drop {
        vesting_id: address,
        beneficiary: address,
        total_amount: u64,
        vesting_duration: u64,
        time_unit: u8,
        release_per_minute: u64,
        start_time: u64,
    }

    struct TokensClaimed has copy, drop {
        vesting_id: address,
        beneficiary: address,
        amount_claimed: u64,
        claim_time: u64,
        total_claimed: u64,
    }

    struct VestingCompleted has copy, drop {
        vesting_id: address,
        beneficiary: address,
        total_amount: u64,
        completion_time: u64,
    }

    public fun beneficiary<T0>(arg0: &VestingSchedule<T0>) : address {
        arg0.beneficiary
    }

    fun calculate_claimable_amount<T0>(arg0: &VestingSchedule<T0>, arg1: u64) : u64 {
        if (arg1 < arg0.start_time) {
            return 0
        };
        let v0 = (arg1 - arg0.start_time) / 60000;
        let v1 = calculate_total_minutes(arg0.vesting_duration, arg0.time_unit);
        assert!(v1 <= 18446744073709551615 / arg0.time_extension_factor, 6);
        let v2 = v1 * arg0.time_extension_factor;
        let v3 = if (v0 < v2) {
            v0
        } else {
            v2
        };
        let v4 = arg0.total_amount / v2;
        assert!(v3 <= 18446744073709551615 / v4, 6);
        let v5 = v3 * v4;
        let v6 = if (v5 > arg0.total_amount) {
            arg0.total_amount
        } else {
            v5
        };
        if (v6 > arg0.claimed_amount) {
            v6 - arg0.claimed_amount
        } else {
            0
        }
    }

    fun calculate_total_minutes(arg0: u64, arg1: u8) : u64 {
        if (arg1 == 0) {
            arg0
        } else if (arg1 == 1) {
            assert!(arg0 <= 18446744073709551615 / 60, 6);
            arg0 * 60
        } else {
            assert!(arg0 <= 18446744073709551615 / 1440, 6);
            arg0 * 1440
        }
    }

    public fun claim_vested_tokens<T0>(arg0: &mut VestingSchedule<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.beneficiary, 2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = calculate_claimable_amount<T0>(arg0, v1);
        assert!(v2 > 0, 3);
        let v3 = v2 < arg0.total_amount && arg0.claimed_amount + v2 < arg0.total_amount;
        arg0.claimed_amount = arg0.claimed_amount + v2;
        arg0.last_claim_time = v1;
        if (v3) {
            arg0.partial_claim_count = arg0.partial_claim_count + 1;
            assert!(arg0.time_extension_factor <= 18446744073709551615 / 2, 6);
            arg0.time_extension_factor = arg0.time_extension_factor * 2;
        };
        let v4 = TokensClaimed{
            vesting_id     : 0x2::object::uid_to_address(&arg0.id),
            beneficiary    : v0,
            amount_claimed : v2,
            claim_time     : v1,
            total_claimed  : arg0.claimed_amount,
        };
        0x2::event::emit<TokensClaimed>(v4);
        if (arg0.claimed_amount == arg0.total_amount) {
            let v5 = VestingCompleted{
                vesting_id      : 0x2::object::uid_to_address(&arg0.id),
                beneficiary     : v0,
                total_amount    : arg0.total_amount,
                completion_time : v1,
            };
            0x2::event::emit<VestingCompleted>(v5);
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v2), arg2)
    }

    public fun claimed_amount<T0>(arg0: &VestingSchedule<T0>) : u64 {
        arg0.claimed_amount
    }

    public fun create_vesting<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : VestingSchedule<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 4);
        assert!(v0 <= 1000000000000000000, 5);
        assert!(arg3 <= 2, 1);
        if (arg3 == 0) {
            assert!(arg2 > 0 && arg2 <= 525600, 0);
        } else if (arg3 == 1) {
            assert!(arg2 > 0 && arg2 <= 8760, 0);
        } else {
            assert!(arg2 > 0 && arg2 <= 365, 0);
        };
        let v1 = calculate_total_minutes(arg2, arg3);
        assert!(v1 > 0, 0);
        let v2 = v0 / v1;
        assert!(v2 > 0, 0);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = VestingSchedule<T0>{
            id                    : 0x2::object::new(arg5),
            balance               : 0x2::coin::into_balance<T0>(arg0),
            beneficiary           : arg1,
            total_amount          : v0,
            claimed_amount        : 0,
            start_time            : v3,
            vesting_duration      : arg2,
            time_unit             : arg3,
            release_per_minute    : v2,
            last_claim_time       : v3,
            partial_claim_count   : 0,
            time_extension_factor : 1,
        };
        let v5 = VestingCreated{
            vesting_id         : 0x2::object::uid_to_address(&v4.id),
            beneficiary        : arg1,
            total_amount       : v0,
            vesting_duration   : arg2,
            time_unit          : arg3,
            release_per_minute : v2,
            start_time         : v3,
        };
        0x2::event::emit<VestingCreated>(v5);
        v4
    }

    public fun get_claimable_amount<T0>(arg0: &VestingSchedule<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.start_time) {
            0
        } else {
            calculate_claimable_amount<T0>(arg0, v0)
        }
    }

    public fun is_fully_vested<T0>(arg0: &VestingSchedule<T0>, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.start_time) {
            return false
        };
        let v1 = calculate_total_minutes(arg0.vesting_duration, arg0.time_unit);
        assert!(v1 <= 18446744073709551615 / arg0.time_extension_factor, 6);
        (v0 - arg0.start_time) / 60000 >= v1 * arg0.time_extension_factor || arg0.claimed_amount == arg0.total_amount
    }

    public fun last_claim_time<T0>(arg0: &VestingSchedule<T0>) : u64 {
        arg0.last_claim_time
    }

    public fun minutes_until_fully_vested<T0>(arg0: &VestingSchedule<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = calculate_total_minutes(arg0.vesting_duration, arg0.time_unit);
        assert!(v1 <= 18446744073709551615 / arg0.time_extension_factor, 6);
        let v2 = v1 * arg0.time_extension_factor;
        if (v0 < arg0.start_time) {
            return v2
        };
        let v3 = (v0 - arg0.start_time) / 60000;
        if (v3 >= v2) {
            0
        } else {
            v2 - v3
        }
    }

    public fun partial_claim_count<T0>(arg0: &VestingSchedule<T0>) : u64 {
        arg0.partial_claim_count
    }

    public fun release_per_minute<T0>(arg0: &VestingSchedule<T0>) : u64 {
        arg0.release_per_minute
    }

    public fun remaining_amount<T0>(arg0: &VestingSchedule<T0>) : u64 {
        arg0.total_amount - arg0.claimed_amount
    }

    public fun start_time<T0>(arg0: &VestingSchedule<T0>) : u64 {
        arg0.start_time
    }

    public fun time_extension_factor<T0>(arg0: &VestingSchedule<T0>) : u64 {
        arg0.time_extension_factor
    }

    public fun time_unit<T0>(arg0: &VestingSchedule<T0>) : u8 {
        arg0.time_unit
    }

    public fun time_unit_to_string(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            b"minutes"
        } else if (arg0 == 1) {
            b"hours"
        } else {
            b"days"
        }
    }

    public fun total_amount<T0>(arg0: &VestingSchedule<T0>) : u64 {
        arg0.total_amount
    }

    public fun vesting_duration<T0>(arg0: &VestingSchedule<T0>) : u64 {
        arg0.vesting_duration
    }

    // decompiled from Move bytecode v6
}

