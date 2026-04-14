module 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_deposit {
    struct DepositResult has copy, drop {
        shares_to_mint: u128,
        allocation: vector<0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::ProtocolAmount>,
    }

    public fun allocation(arg0: &DepositResult) : &vector<0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::ProtocolAmount> {
        &arg0.allocation
    }

    public(friend) fun build_deposit_result(arg0: u128, arg1: &vector<0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::ProtocolAmount>) : DepositResult {
        DepositResult{
            shares_to_mint : arg0,
            allocation     : *arg1,
        }
    }

    public fun calculate_deposit<T0, T1>(arg0: &0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::LLVPool<T0, T1>, arg1: u64) : DepositResult {
        let (v0, _) = calculate_deposit_with_queue<T0, T1>(arg0, arg1);
        DepositResult{
            shares_to_mint : calculate_shares_for_amount<T0, T1>(arg0, (arg1 as u128)),
            allocation     : v0,
        }
    }

    public fun calculate_deposit_with_queue<T0, T1>(arg0: &0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::LLVPool<T0, T1>, arg1: u64) : (vector<0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::ProtocolAmount>, u64) {
        assert!(arg1 > 0, 2);
        assert!(arg1 >= 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::get_min_deposit<T0, T1>(arg0), 3);
        let v0 = 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::get_total_assets<T0, T1>(arg0);
        0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::assert_deposit_cap<T0, T1>(arg0, v0, arg1);
        let v1 = 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::get_supply_queue<T0, T1>(arg0);
        assert!(0x1::vector::length<u8>(&v1) > 0, 5);
        let v2 = (arg1 as u128);
        let v3 = 0x1::vector::empty<0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::ProtocolAmount>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v1) && v2 > 0) {
            let v5 = *0x1::vector::borrow<u8>(&v1, v4);
            if (0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::is_protocol_supply_enabled<T0, T1>(arg0, v5)) {
                let v6 = (v0 + (arg1 as u128)) * (0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::get_protocol_ratio<T0, T1>(arg0, v5) as u128) / 10000;
                let v7 = 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::get_protocol_balance<T0, T1>(arg0, v5);
                if (v6 > v7) {
                    let v8 = v6 - v7;
                    let v9 = 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::get_protocol_remaining_capacity<T0, T1>(arg0, v5);
                    let v10 = if (v8 < v9) {
                        v8
                    } else {
                        v9
                    };
                    let v11 = if (v10 < v2) {
                        v10
                    } else {
                        v2
                    };
                    if (v11 > 0) {
                        0x1::vector::push_back<0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::ProtocolAmount>(&mut v3, 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::create(v5, v11));
                        v2 = v2 - v11;
                    };
                };
            };
            v4 = v4 + 1;
        };
        if (v2 > 0) {
            0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::accumulate(&mut v3, 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::PROTOCOL_IDLE(), v2);
            v2 = 0;
        };
        (v3, (v2 as u64))
    }

    public fun calculate_shares_for_amount<T0, T1>(arg0: &0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::LLVPool<T0, T1>, arg1: u128) : u128 {
        assert!(arg1 <= 18446744073709551615, 6);
        let v0 = 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_math::calculate_shares_with_min(0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::total_shares<T0, T1>(arg0), 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::get_total_assets<T0, T1>(arg0), (arg1 as u64), 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::get_min_shares<T0, T1>(arg0));
        assert!(v0 <= 18446744073709551615, 7);
        v0
    }

    public(friend) fun record_deposit_state<T0, T1>(arg0: &mut 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::LLVPool<T0, T1>, arg1: &vector<0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::ProtocolAmount>, arg2: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::ProtocolAmount>(arg1)) {
            let v1 = 0x1::vector::borrow<0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::ProtocolAmount>(arg1, v0);
            let v2 = 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::amount(v1);
            if (v2 > 0) {
                0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::record_deposit<T0, T1>(arg0, 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_allocation_plan::protocol_id(v1), v2, arg2);
            };
            v0 = v0 + 1;
        };
    }

    public fun shares_to_mint(arg0: &DepositResult) : u128 {
        arg0.shares_to_mint
    }

    public fun verify_min_shares(arg0: u128, arg1: u128) {
        assert!(arg0 >= arg1, 4);
    }

    // decompiled from Move bytecode v7
}

