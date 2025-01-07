module 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::fee {
    struct WhitelistCoin has drop, store {
        enabled: bool,
        launched: bool,
    }

    struct Fee has copy, drop, store {
        burn: u64,
        gov1: u64,
        gov2: u64,
        liquidity: u64,
        jackpot: u64,
        bonus: u64,
        dev: u64,
        total: u64,
    }

    struct FeeReceiver has copy, drop, store {
        gov1_addr: address,
        gov2_addr: address,
        bonus_addr: address,
        dev_address: address,
    }

    struct FeeStore<phantom T0> has store {
        buy_fee: Fee,
        sell_fee: Fee,
        fee_pool: 0x2::balance::Balance<T0>,
        jackpot_store: 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::jackpot::JackpotStore<T0>,
        whitelist_pairs: 0x2::table::Table<0x1::ascii::String, WhitelistCoin>,
        receiver: FeeReceiver,
        is_fee_exempt: vector<address>,
        can_add_lp: vector<address>,
    }

    public(friend) fun add_can_add_lp<T0, T1>(arg0: &mut FeeStore<T0>, arg1: address) {
        assert!(!0x1::vector::contains<address>(&arg0.can_add_lp, &arg1), 2);
        0x1::vector::push_back<address>(&mut arg0.can_add_lp, arg1);
    }

    public(friend) fun add_fee_exempt<T0, T1>(arg0: &mut FeeStore<T0>, arg1: address) {
        assert!(!0x1::vector::contains<address>(&arg0.is_fee_exempt, &arg1), 2);
        0x1::vector::push_back<address>(&mut arg0.is_fee_exempt, arg1);
    }

    public(friend) fun distribute_fee<T0>(arg0: &mut FeeStore<T0>, arg1: Fee, arg2: u64, arg3: u64, arg4: u64, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.receiver;
        transfer_out<T0>(arg0, arg2, @0xdead, arg6);
        transfer_out<T0>(arg0, arg4, v0.bonus_addr, arg6);
        let v1 = arg1.total - arg1.burn - arg1.liquidity - arg1.bonus;
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg5);
        let v3 = 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::math::mul_div(v2, arg1.gov1, v1);
        let v4 = 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::math::mul_div(v2, arg1.gov2, v1);
        let v5 = 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::math::mul_div(v2, arg1.jackpot, v1);
        let v6 = v2 - v3 - v4 - v5;
        let v7 = &mut arg5;
        transfer_sui_out(v7, v3, v0.gov1_addr, arg6);
        let v8 = &mut arg5;
        transfer_sui_out(v8, v4, v0.gov2_addr, arg6);
        let v9 = &mut arg5;
        transfer_sui_out(v9, v6, v0.dev_address, arg6);
        0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::jackpot::add_price_balance<T0>(&mut arg0.jackpot_store, arg5);
        0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::event::swap_back_event<T0>(arg2, arg3, arg4, v3, v4, v5, v6);
    }

    public fun get_fee<T0>(arg0: bool, arg1: &FeeStore<T0>) : Fee {
        if (arg0) {
            arg1.buy_fee
        } else {
            arg1.sell_fee
        }
    }

    public(friend) fun get_fee_amount<T0>(arg0: &mut FeeStore<T0>, arg1: u64, arg2: Fee) : (u64, u64, u64, 0x2::balance::Balance<T0>) {
        let v0 = 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::math::mul_div(arg1, arg2.burn, arg2.total);
        let v1 = 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::math::mul_div(arg1, arg2.liquidity, arg2.total);
        let v2 = 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::math::mul_div(arg1, arg2.bonus, arg2.total);
        (v0, v1, v2, 0x2::balance::split<T0>(&mut arg0.fee_pool, arg1 - v0 - v1 - v2))
    }

    public fun get_jackpot_store<T0>(arg0: &FeeStore<T0>) : &0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::jackpot::JackpotStore<T0> {
        &arg0.jackpot_store
    }

    public(friend) fun initialize<T0>(arg0: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject, arg1: &mut 0x2::tx_context::TxContext) : FeeStore<T0> {
        let v0 = Fee{
            burn      : 100,
            gov1      : 100,
            gov2      : 200,
            liquidity : 200,
            jackpot   : 300,
            bonus     : 300,
            dev       : 300,
            total     : 1500,
        };
        let v1 = FeeReceiver{
            gov1_addr   : @0xff53df8926677d642a90ef0bad7fd43e7f893dbf64ca5e88f8e0ecced5d5dbf3,
            gov2_addr   : @0x3f083d8043296c1faf4fb9fd9adeda3484f7944ed528c90125871a57ab58c86f,
            bonus_addr  : @0xb9c0d90265c5ac8cf98dc658787eebdea3add220835f67dba0c60c55193c23db,
            dev_address : @0xf39e84eb777ec29ebb016e5319900d74ebec830a36b75d8c6aed08ba018d9f2d,
        };
        FeeStore<T0>{
            buy_fee         : v0,
            sell_fee        : v0,
            fee_pool        : 0x2::balance::zero<T0>(),
            jackpot_store   : 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::jackpot::create_jackpot<T0>(arg0),
            whitelist_pairs : 0x2::table::new<0x1::ascii::String, WhitelistCoin>(arg1),
            receiver        : v1,
            is_fee_exempt   : 0x1::vector::empty<address>(),
            can_add_lp      : 0x1::vector::empty<address>(),
        }
    }

    public(friend) fun lottery_jackpot<T0>(arg0: &0x2::clock::Clock, arg1: &mut FeeStore<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::jackpot::lottery<T0>(arg0, &mut arg1.jackpot_store, arg2);
    }

    public fun pool_balance<T0>(arg0: &FeeStore<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fee_pool)
    }

    public(friend) fun remove_can_add_lp<T0, T1>(arg0: &mut FeeStore<T0>, arg1: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.can_add_lp, &arg1);
        assert!(v0, 3);
        0x1::vector::remove<address>(&mut arg0.can_add_lp, v1);
    }

    public(friend) fun remove_fee_exempt<T0, T1>(arg0: &mut FeeStore<T0>, arg1: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.is_fee_exempt, &arg1);
        assert!(v0, 3);
        0x1::vector::remove<address>(&mut arg0.is_fee_exempt, v1);
    }

    public(friend) fun should_take_fee<T0, T1>(arg0: address, arg1: &FeeStore<T0>) : bool {
        let v0 = 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::utils::get_type_name_str<T1>();
        if (0x2::table::contains<0x1::ascii::String, WhitelistCoin>(&arg1.whitelist_pairs, v0)) {
            let v2 = 0x2::table::borrow<0x1::ascii::String, WhitelistCoin>(&arg1.whitelist_pairs, v0);
            if (v2.enabled) {
                assert!(0x1::vector::contains<address>(&arg1.can_add_lp, &arg0) || v2.launched, 1);
                !0x1::vector::contains<address>(&arg1.is_fee_exempt, &arg0) && v2.launched
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun take_fee<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: bool, arg3: &mut FeeStore<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Fee) {
        let v0 = if (arg2) {
            0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::jackpot::trade_event<T0>(0x2::coin::value<T0>(&arg0), arg1, &mut arg3.jackpot_store, arg4);
            arg3.buy_fee
        } else {
            arg3.sell_fee
        };
        let v1 = v0;
        0x2::balance::join<T0>(&mut arg3.fee_pool, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::math::mul_div(0x2::coin::value<T0>(&arg0), v1.total, 10000), arg4)));
        0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::event::take_fee_event<T0>(0x2::tx_context::sender(arg4), 0x2::coin::value<T0>(&arg0), arg2);
        (arg0, v1)
    }

    fun transfer_out<T0>(arg0: &mut FeeStore<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fee_pool, arg1), arg3), arg2);
    }

    fun transfer_sui_out(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg0, arg1), arg3), arg2);
    }

    public(friend) fun update_jackpot_bonus<T0>(arg0: &mut FeeStore<T0>, arg1: u64, arg2: u64) {
        0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::jackpot::update_bonus<T0>(&mut arg0.jackpot_store, arg1, arg2);
    }

    public(friend) fun update_price<T0>(arg0: &mut FeeStore<T0>, arg1: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg2: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::jackpot::update_price<T0>(&mut arg0.jackpot_store, arg1, arg2, arg3);
    }

    public(friend) fun update_whitelist<T0, T1>(arg0: &mut FeeStore<T0>, arg1: bool, arg2: bool) {
        let v0 = 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::utils::get_type_name_str<T1>();
        if (0x2::table::contains<0x1::ascii::String, WhitelistCoin>(&arg0.whitelist_pairs, v0)) {
            let v1 = 0x2::table::borrow_mut<0x1::ascii::String, WhitelistCoin>(&mut arg0.whitelist_pairs, v0);
            v1.enabled = arg1;
            v1.launched = arg2;
        } else {
            let v2 = WhitelistCoin{
                enabled  : arg1,
                launched : arg2,
            };
            0x2::table::add<0x1::ascii::String, WhitelistCoin>(&mut arg0.whitelist_pairs, v0, v2);
        };
    }

    // decompiled from Move bytecode v6
}

