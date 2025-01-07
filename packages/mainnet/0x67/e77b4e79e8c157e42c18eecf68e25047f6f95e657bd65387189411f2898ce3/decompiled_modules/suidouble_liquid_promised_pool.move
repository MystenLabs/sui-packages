module 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool {
    struct SuidoubleLiquidPromisedWaiting has drop, store {
        expected_sui_amount: u64,
        promise_id: 0x2::object::ID,
    }

    struct SuidoubleLiquidPromisedPoolStillStaked has store {
        staked_sui: 0x3::staking_pool::StakedSui,
        expected_sui_amount: u64,
        promise_id: 0x2::object::ID,
    }

    struct SuidoubleLiquidPromisedPool has store {
        all_time_promised_amount: u64,
        all_time_extra_amount: u64,
        promised_amount: u64,
        promised_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        promised_amount_in_staked: u64,
        promised_staked: 0x2::table::Table<0x2::object::ID, SuidoubleLiquidPromisedPoolStillStaked>,
        got_extra_staked: 0x2::balance::Balance<0x2::sui::SUI>,
        created_at_epoch: u64,
        promised_promised_waiting_by_epoch: 0x2::table::Table<u64, vector<SuidoubleLiquidPromisedWaiting>>,
        still_waiting_for_sui_amount: u64,
        oldest_waiting_epoch: u64,
    }

    public(friend) fun attach_promised_staked_sui(arg0: &mut SuidoubleLiquidPromisedPool, arg1: 0x3::staking_pool::StakedSui, arg2: u64, arg3: 0x2::object::ID) {
        let v0 = SuidoubleLiquidPromisedPoolStillStaked{
            staked_sui          : arg1,
            expected_sui_amount : arg2,
            promise_id          : arg3,
        };
        0x2::table::add<0x2::object::ID, SuidoubleLiquidPromisedPoolStillStaked>(&mut arg0.promised_staked, arg3, v0);
        arg0.promised_amount_in_staked = arg0.promised_amount_in_staked + arg2;
        arg0.promised_amount = arg0.promised_amount - arg2;
    }

    public(friend) fun contains_promised_waiting_by_epoch(arg0: &mut SuidoubleLiquidPromisedPool, arg1: u64) : bool {
        if (arg1 > 0) {
            let v0 = arg1 - 1;
            while (v0 >= arg0.oldest_waiting_epoch && v0 > 0) {
                if (0x2::table::contains<u64, vector<SuidoubleLiquidPromisedWaiting>>(&arg0.promised_promised_waiting_by_epoch, v0)) {
                    if (0x2::table::contains<u64, vector<SuidoubleLiquidPromisedWaiting>>(&arg0.promised_promised_waiting_by_epoch, arg1)) {
                        0x1::vector::append<SuidoubleLiquidPromisedWaiting>(0x2::table::borrow_mut<u64, vector<SuidoubleLiquidPromisedWaiting>>(&mut arg0.promised_promised_waiting_by_epoch, arg1), 0x2::table::remove<u64, vector<SuidoubleLiquidPromisedWaiting>>(&mut arg0.promised_promised_waiting_by_epoch, v0));
                    } else {
                        let v1 = 0x1::vector::empty<SuidoubleLiquidPromisedWaiting>();
                        0x1::vector::append<SuidoubleLiquidPromisedWaiting>(&mut v1, 0x2::table::remove<u64, vector<SuidoubleLiquidPromisedWaiting>>(&mut arg0.promised_promised_waiting_by_epoch, v0));
                        0x2::table::add<u64, vector<SuidoubleLiquidPromisedWaiting>>(&mut arg0.promised_promised_waiting_by_epoch, arg1, v1);
                    };
                };
                if (v0 > 0) {
                    v0 = v0 - 1;
                };
            };
        };
        arg0.oldest_waiting_epoch = arg1;
        if (0x2::table::contains<u64, vector<SuidoubleLiquidPromisedWaiting>>(&arg0.promised_promised_waiting_by_epoch, arg1)) {
            return true
        };
        false
    }

    public(friend) fun default(arg0: &mut 0x2::tx_context::TxContext) : SuidoubleLiquidPromisedPool {
        let v0 = 0x2::tx_context::epoch(arg0);
        SuidoubleLiquidPromisedPool{
            all_time_promised_amount           : 0,
            all_time_extra_amount              : 0,
            promised_amount                    : 0,
            promised_sui                       : 0x2::balance::zero<0x2::sui::SUI>(),
            promised_amount_in_staked          : 0,
            promised_staked                    : 0x2::table::new<0x2::object::ID, SuidoubleLiquidPromisedPoolStillStaked>(arg0),
            got_extra_staked                   : 0x2::balance::zero<0x2::sui::SUI>(),
            created_at_epoch                   : v0,
            promised_promised_waiting_by_epoch : 0x2::table::new<u64, vector<SuidoubleLiquidPromisedWaiting>>(arg0),
            still_waiting_for_sui_amount       : 0,
            oldest_waiting_epoch               : v0,
        }
    }

    public(friend) fun fulfill_with_sui(arg0: &mut SuidoubleLiquidPromisedPool, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.promised_sui, arg1);
        arg0.still_waiting_for_sui_amount = arg0.still_waiting_for_sui_amount - v0;
        arg0.promised_amount = arg0.promised_amount - v0;
    }

    public(friend) fun increment_promised_amount(arg0: &mut SuidoubleLiquidPromisedPool, arg1: u64, arg2: u64, arg3: 0x2::object::ID) {
        arg0.all_time_promised_amount = arg0.all_time_promised_amount + arg1;
        arg0.promised_amount = arg0.promised_amount + arg1;
        let v0 = SuidoubleLiquidPromisedWaiting{
            expected_sui_amount : arg1,
            promise_id          : arg3,
        };
        if (0x2::table::contains<u64, vector<SuidoubleLiquidPromisedWaiting>>(&arg0.promised_promised_waiting_by_epoch, arg2)) {
            0x1::vector::push_back<SuidoubleLiquidPromisedWaiting>(0x2::table::borrow_mut<u64, vector<SuidoubleLiquidPromisedWaiting>>(&mut arg0.promised_promised_waiting_by_epoch, arg2), v0);
        } else {
            0x2::table::add<u64, vector<SuidoubleLiquidPromisedWaiting>>(&mut arg0.promised_promised_waiting_by_epoch, arg2, 0x1::vector::singleton<SuidoubleLiquidPromisedWaiting>(v0));
        };
    }

    public(friend) fun is_there_promised_staked_sui(arg0: &SuidoubleLiquidPromisedPool, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, SuidoubleLiquidPromisedPoolStillStaked>(&arg0.promised_staked, arg1)
    }

    public(friend) fun promised_amount(arg0: &SuidoubleLiquidPromisedPool) : u64 {
        arg0.promised_amount
    }

    public(friend) fun promised_amount_at_epoch(arg0: &mut SuidoubleLiquidPromisedPool, arg1: u64) : u64 {
        let v0 = 0;
        if (contains_promised_waiting_by_epoch(arg0, arg1)) {
            let v1 = 0x2::table::borrow_mut<u64, vector<SuidoubleLiquidPromisedWaiting>>(&mut arg0.promised_promised_waiting_by_epoch, arg1);
            let v2 = 0;
            while (v2 < 0x1::vector::length<SuidoubleLiquidPromisedWaiting>(v1)) {
                v0 = v0 + 0x1::vector::borrow<SuidoubleLiquidPromisedWaiting>(v1, v2).expected_sui_amount;
                v2 = v2 + 1;
            };
        };
        v0
    }

    public(friend) fun still_waiting_for_sui_amount(arg0: &SuidoubleLiquidPromisedPool) : u64 {
        arg0.still_waiting_for_sui_amount
    }

    public(friend) fun take_extra_staked_balance(arg0: &mut SuidoubleLiquidPromisedPool) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.got_extra_staked)
    }

    public(friend) fun take_promised_staked_sui(arg0: &mut SuidoubleLiquidPromisedPool, arg1: 0x2::object::ID, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let SuidoubleLiquidPromisedPoolStillStaked {
            staked_sui          : v0,
            expected_sui_amount : v1,
            promise_id          : _,
        } = 0x2::table::remove<0x2::object::ID, SuidoubleLiquidPromisedPoolStillStaked>(&mut arg0.promised_staked, arg1);
        let v3 = 0x3::sui_system::request_withdraw_stake_non_entry(arg2, v0, arg3);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        let v5 = v1;
        if (v1 > v4) {
            v5 = v4;
        };
        arg0.promised_amount_in_staked = arg0.promised_amount_in_staked - v5;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.got_extra_staked, v3);
        arg0.all_time_extra_amount = arg0.all_time_extra_amount + 0x2::balance::value<0x2::sui::SUI>(&v3);
        0x2::coin::take<0x2::sui::SUI>(&mut v3, v5, arg3)
    }

    public(friend) fun take_sui(arg0: &mut SuidoubleLiquidPromisedPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.promised_sui, arg1, arg2)
    }

    public(friend) fun try_to_fill_with_perfect_staked_sui(arg0: &mut SuidoubleLiquidPromisedPool, arg1: &mut 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_staker::SuidoubleLiquidStaker, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg3);
        let v1 = 0;
        if (contains_promised_waiting_by_epoch(arg0, v0)) {
            let v2 = 0x2::table::remove<u64, vector<SuidoubleLiquidPromisedWaiting>>(&mut arg0.promised_promised_waiting_by_epoch, v0);
            let v3 = 0;
            while (v3 < 0x1::vector::length<SuidoubleLiquidPromisedWaiting>(&v2)) {
                let v4 = 0x1::vector::pop_back<SuidoubleLiquidPromisedWaiting>(&mut v2);
                let v5 = v4.expected_sui_amount;
                let v6 = 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_staker::find_the_perfect_staked_sui(arg1, v5, arg2, arg3);
                if (0x1::option::is_some<0x3::staking_pool::StakedSui>(&v6)) {
                    attach_promised_staked_sui(arg0, 0x1::option::destroy_some<0x3::staking_pool::StakedSui>(v6), v5, v4.promise_id);
                } else {
                    0x1::option::destroy_none<0x3::staking_pool::StakedSui>(v6);
                    v1 = v1 + v5;
                };
                v3 = v3 + 1;
            };
            arg0.still_waiting_for_sui_amount = arg0.still_waiting_for_sui_amount + v1;
        };
    }

    // decompiled from Move bytecode v6
}

