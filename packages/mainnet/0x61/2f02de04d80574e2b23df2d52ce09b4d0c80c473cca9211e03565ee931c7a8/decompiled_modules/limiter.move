module 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::limiter {
    struct TransferLimiter has store {
        transfer_limits: 0x2::vec_map::VecMap<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::BridgeRoute, u64>,
        transfer_records: 0x2::vec_map::VecMap<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::BridgeRoute, TransferRecord>,
    }

    struct TransferRecord has store {
        hour_head: u64,
        hour_tail: u64,
        per_hour_amounts: vector<u64>,
        total_amount: u64,
    }

    struct UpdateRouteLimitEvent has copy, drop {
        sending_chain: u8,
        sending_token: u8,
        new_limit: u64,
    }

    fun adjust_transfer_records(arg0: &mut TransferRecord, arg1: u64) {
        if (arg0.hour_head == arg1) {
            return
        };
        let v0 = arg1 - 23;
        if (arg0.hour_head < v0) {
            arg0.per_hour_amounts = vector[];
            arg0.total_amount = 0;
            arg0.hour_tail = v0;
            arg0.hour_head = v0;
            0x1::vector::push_back<u64>(&mut arg0.per_hour_amounts, 0);
        } else {
            while (arg0.hour_tail < v0) {
                arg0.total_amount = arg0.total_amount - 0x1::vector::remove<u64>(&mut arg0.per_hour_amounts, 0);
                arg0.hour_tail = arg0.hour_tail + 1;
            };
        };
        while (arg0.hour_head < arg1) {
            0x1::vector::push_back<u64>(&mut arg0.per_hour_amounts, 0);
            arg0.hour_head = arg0.hour_head + 1;
        };
    }

    public(friend) fun check_and_record_sending_transfer<T0>(arg0: &mut TransferLimiter, arg1: &0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::treasury::BridgeTreasury, arg2: &0x2::clock::Clock, arg3: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::BridgeRoute, arg4: u64) : bool {
        if (!0x2::vec_map::contains<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::BridgeRoute, TransferRecord>(&arg0.transfer_records, &arg3)) {
            let v0 = TransferRecord{
                hour_head        : 0,
                hour_tail        : 0,
                per_hour_amounts : vector[],
                total_amount     : 0,
            };
            0x2::vec_map::insert<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::BridgeRoute, TransferRecord>(&mut arg0.transfer_records, arg3, v0);
        };
        let v1 = 0x2::vec_map::get_mut<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::BridgeRoute, TransferRecord>(&mut arg0.transfer_records, &arg3);
        adjust_transfer_records(v1, current_hour_since_epoch(arg2));
        let v2 = 0x2::vec_map::try_get<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::BridgeRoute, u64>(&arg0.transfer_limits, &arg3);
        assert!(0x1::option::is_some<u64>(&v2), 0);
        let v3 = (0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::treasury::notional_value<T0>(arg1) as u128) * (arg4 as u128);
        if ((v1.total_amount as u128) * (0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::treasury::decimal_multiplier<T0>(arg1) as u128) + v3 > (0x1::option::destroy_some<u64>(v2) as u128) * (0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::treasury::decimal_multiplier<T0>(arg1) as u128)) {
            return false
        };
        let v4 = ((v3 / (0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::treasury::decimal_multiplier<T0>(arg1) as u128)) as u64);
        0x1::vector::push_back<u64>(&mut v1.per_hour_amounts, 0x1::vector::pop_back<u64>(&mut v1.per_hour_amounts) + v4);
        v1.total_amount = v1.total_amount + v4;
        true
    }

    fun current_hour_since_epoch(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 3600000
    }

    public fun get_route_limit(arg0: &TransferLimiter, arg1: &0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::BridgeRoute) : u64 {
        *0x2::vec_map::get<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::BridgeRoute, u64>(&arg0.transfer_limits, arg1)
    }

    public(friend) fun new() : TransferLimiter {
        TransferLimiter{
            transfer_limits  : 0x2::vec_map::empty<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::BridgeRoute, u64>(),
            transfer_records : 0x2::vec_map::empty<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::BridgeRoute, TransferRecord>(),
        }
    }

    public(friend) fun update_route_limit(arg0: &mut TransferLimiter, arg1: &0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::BridgeRoute, arg2: u64) {
        if (!0x2::vec_map::contains<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::BridgeRoute, u64>(&arg0.transfer_limits, arg1)) {
            0x2::vec_map::insert<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::BridgeRoute, u64>(&mut arg0.transfer_limits, *arg1, arg2);
        } else {
            *0x2::vec_map::get_mut<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::BridgeRoute, u64>(&mut arg0.transfer_limits, arg1) = arg2;
        };
        let v0 = UpdateRouteLimitEvent{
            sending_chain : *0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::route_destination(arg1),
            sending_token : *0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::route_token(arg1),
            new_limit     : arg2,
        };
        0x2::event::emit<UpdateRouteLimitEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

