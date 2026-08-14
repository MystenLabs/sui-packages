module 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::stake_ladder {
    public fun capture_bps() : u64 {
        6 * 10000 / 7
    }

    public(friend) fun harvest_matured(arg0: &mut vector<0x3::staking_pool::StakedSui>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u64) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0;
        let v2 = 0x1::vector::empty<0x3::staking_pool::StakedSui>();
        while (!0x1::vector::is_empty<0x3::staking_pool::StakedSui>(arg0)) {
            let v3 = 0x1::vector::pop_back<0x3::staking_pool::StakedSui>(arg0);
            if (!is_matured(&v3, 0x2::tx_context::epoch(arg2))) {
                0x1::vector::push_back<0x3::staking_pool::StakedSui>(&mut v2, v3);
                continue
            };
            let v4 = 0x3::staking_pool::staked_sui_amount(&v3);
            let v5 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, v3, arg2);
            assert!(0x2::balance::value<0x2::sui::SUI>(&v5) >= v4, 101);
            v1 = v1 + v4;
            0x2::balance::join<0x2::sui::SUI>(&mut v0, v5);
        };
        while (!0x1::vector::is_empty<0x3::staking_pool::StakedSui>(&v2)) {
            0x1::vector::push_back<0x3::staking_pool::StakedSui>(arg0, 0x1::vector::pop_back<0x3::staking_pool::StakedSui>(&mut v2));
        };
        0x1::vector::destroy_empty<0x3::staking_pool::StakedSui>(v2);
        (v0, v1)
    }

    public fun is_converged(arg0: &vector<0x3::staking_pool::StakedSui>) : bool {
        0x1::vector::length<0x3::staking_pool::StakedSui>(arg0) == 7
    }

    public fun is_matured(arg0: &0x3::staking_pool::StakedSui, arg1: u64) : bool {
        0x3::staking_pool::stake_activation_epoch(arg0) + 6 <= arg1
    }

    public fun ladder_depth() : u64 {
        6
    }

    public fun max_tranches() : u64 {
        16
    }

    public fun min_stake_mist() : u64 {
        1000000000
    }

    public fun rung_size(arg0: u64) : u64 {
        let v0 = arg0 / 7;
        if (v0 < 1000000000) {
            1000000000
        } else {
            v0
        }
    }

    public fun rungs() : u64 {
        7
    }

    public(friend) fun stake_one_rung(arg0: &mut vector<0x3::staking_pool::StakedSui>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg3 <= 0x2::balance::value<0x2::sui::SUI>(arg2), 102);
        if (arg3 < 1000000000) {
            return 0
        };
        if (0x1::vector::length<0x3::staking_pool::StakedSui>(arg0) >= 16) {
            return 0
        };
        if (staked_this_epoch(arg0, 0x2::tx_context::epoch(arg6))) {
            return 0
        };
        let v0 = rung_size(arg4);
        let v1 = if (arg3 < v0) {
            arg3
        } else {
            v0
        };
        0x1::vector::push_back<0x3::staking_pool::StakedSui>(arg0, 0x3::sui_system::request_add_stake_non_entry(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg2, v1), arg6), arg5, arg6));
        v1
    }

    public fun staked_principal(arg0: &vector<0x3::staking_pool::StakedSui>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x3::staking_pool::StakedSui>(arg0)) {
            v0 = v0 + 0x3::staking_pool::staked_sui_amount(0x1::vector::borrow<0x3::staking_pool::StakedSui>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun staked_this_epoch(arg0: &vector<0x3::staking_pool::StakedSui>, arg1: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x3::staking_pool::StakedSui>(arg0)) {
            if (0x3::staking_pool::stake_activation_epoch(0x1::vector::borrow<0x3::staking_pool::StakedSui>(arg0, v0)) > arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun unwind_newest(arg0: &mut vector<0x3::staking_pool::StakedSui>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u64) {
        if (0x1::vector::is_empty<0x3::staking_pool::StakedSui>(arg0)) {
            return (0x2::balance::zero<0x2::sui::SUI>(), 0)
        };
        let v0 = 0x1::vector::pop_back<0x3::staking_pool::StakedSui>(arg0);
        let v1 = 0x3::staking_pool::staked_sui_amount(&v0);
        let v2 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, v0, arg2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v2) >= v1, 101);
        (v2, v1)
    }

    // decompiled from Move bytecode v7
}

