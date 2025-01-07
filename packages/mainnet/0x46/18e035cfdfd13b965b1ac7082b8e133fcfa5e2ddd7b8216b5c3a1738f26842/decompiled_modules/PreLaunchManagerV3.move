module 0x4618e035cfdfd13b965b1ac7082b8e133fcfa5e2ddd7b8216b5c3a1738f26842::PreLaunchManagerV3 {
    struct Round has store, key {
        id: 0x2::object::UID,
        round_id: u64,
        token_contract: vector<u8>,
        name: vector<u8>,
        symbol: vector<u8>,
        total_supply: u64,
        total_raised: u64,
        hard_cap: u64,
        end_epoch: u64,
        time_frame: u64,
        is_finished: bool,
        telegram: vector<u8>,
        twitter: vector<u8>,
        website: vector<u8>,
        description: vector<u64>,
        imageURL: vector<u8>,
        sponsored: bool,
        creator: address,
        contributions: vector<RoundUserContribution>,
    }

    struct RoundUserContribution has store, key {
        id: 0x2::object::UID,
        user: address,
        amount: u64,
        collected_amount: u64,
        next_collect_timestamp: u64,
        collect_count: u64,
        collected: bool,
    }

    struct PreLaunchManagerV3 has store, key {
        id: 0x2::object::UID,
        creator: address,
        creation_fee: u64,
        sponsorship_fee: u64,
        cro_home_fee: u64,
        platform_fee_percentage: u64,
        burn_fee_percentage: u64,
        prize_fee_percentage: u64,
        burn_token: address,
        treasury: address,
        rounds: vector<Round>,
    }

    struct CoinTypeA has store {
        dummy_field: bool,
    }

    struct CoinTypeB has store {
        dummy_field: bool,
    }

    fun assert_is_owner(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0);
    }

    public entry fun collect(arg0: &mut PreLaunchManagerV3, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 0x1::vector::length<Round>(&arg0.rounds), 1);
        let v0 = 0x1::vector::borrow_mut<Round>(&mut arg0.rounds, arg1);
        assert!(v0.is_finished, 2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<RoundUserContribution>(&v0.contributions)) {
            let v2 = 0x1::vector::borrow_mut<RoundUserContribution>(&mut v0.contributions, v1);
            if (v2.user == arg2) {
                assert!(v2.amount > 0, 3);
                assert!(!v2.collected, 4);
                assert!(0x2::clock::timestamp_ms(arg3) / 1000 >= v2.next_collect_timestamp, 5);
                let v3 = 0;
                if (v0.total_raised > 0) {
                    v3 = v0.total_supply * 30 / 100 * v2.amount / v0.total_raised;
                };
                let v4 = v3 - v2.collected_amount;
                assert!(v4 > 0, 6);
                let v5 = if (v2.collect_count == 2) {
                    v4
                } else {
                    v3 * 33 / 100
                };
                assert!(v5 > 0, 7);
                v2.collected_amount = v2.collected_amount + v5;
                v2.collect_count = v2.collect_count + 1;
                if (v2.collect_count < 3) {
                    v2.next_collect_timestamp = 0x2::clock::timestamp_ms(arg3) / 1000 + 900000 + 0x2::clock::timestamp_ms(arg3) / 1000 % 660000;
                    break
                } else {
                    v2.collected = true;
                    break
                };
            };
            v1 = v1 + 1;
        };
    }

    public entry fun contribute(arg0: &mut PreLaunchManagerV3, arg1: u64, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        finalize_rounds(arg0, arg4);
        assert!(arg1 < 0x1::vector::length<Round>(&arg0.rounds), 1);
        let v0 = 0x1::vector::borrow_mut<Round>(&mut arg0.rounds, arg1);
        assert!(0x2::clock::timestamp_ms(arg4) / 1000 < v0.end_epoch, 0);
        assert!(v0.total_raised < v0.hard_cap, 0);
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<RoundUserContribution>(&v0.contributions)) {
            let v3 = 0x1::vector::borrow_mut<RoundUserContribution>(&mut v0.contributions, v2);
            if (v3.user == arg2) {
                v3.amount = v3.amount + arg3;
                v1 = true;
                break
            };
            v2 = v2 + 1;
        };
        if (!v1) {
            let v4 = RoundUserContribution{
                id                     : 0x2::object::new(arg5),
                user                   : arg2,
                amount                 : arg3,
                collected_amount       : 0,
                next_collect_timestamp : 0x2::clock::timestamp_ms(arg4) / 1000,
                collect_count          : 0,
                collected              : false,
            };
            0x1::vector::push_back<RoundUserContribution>(&mut v0.contributions, v4);
        };
        v0.total_raised = v0.total_raised + arg3;
    }

    public fun distribute_platform_fee(arg0: &mut PreLaunchManagerV3, arg1: u64, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x2::clock::Clock) {
    }

    public fun finalize_rounds(arg0: &mut PreLaunchManagerV3, arg1: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Round>(&arg0.rounds)) {
            let v1 = 0x1::vector::borrow_mut<Round>(&mut arg0.rounds, v0);
            if (v1.end_epoch <= 0x2::clock::timestamp_ms(arg1) / 1000 || v1.total_raised >= get_hard_cap_current(v1, arg1)) {
                v1.is_finished = true;
            };
            v0 = v0 + 1;
        };
    }

    public entry fun finish_round(arg0: &mut PreLaunchManagerV3, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<CoinTypeA, CoinTypeB>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Round>(&mut arg0.rounds, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg5), 1);
        v0.is_finished = true;
        open_position_with_liquidity_with_all<CoinTypeA, CoinTypeB>(arg3, arg4, 1, 100, 10, 10, false, arg2, arg5);
    }

    public fun get_hard_cap_current(arg0: &Round, arg1: &0x2::clock::Clock) : u64 {
        arg0.hard_cap * (arg0.time_frame - (arg0.end_epoch - 0x2::clock::timestamp_ms(arg1) / 1000) / 60) / arg0.time_frame
    }

    public fun init_contract(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : PreLaunchManagerV3 {
        PreLaunchManagerV3{
            id                      : 0x2::object::new(arg8),
            creator                 : 0x2::tx_context::sender(arg8),
            creation_fee            : arg0,
            sponsorship_fee         : arg1,
            cro_home_fee            : arg2,
            platform_fee_percentage : arg3,
            burn_fee_percentage     : arg5,
            prize_fee_percentage    : arg4,
            burn_token              : arg6,
            treasury                : arg7,
            rounds                  : 0x1::vector::empty<Round>(),
        }
    }

    public entry fun open_position_with_liquidity_with_all<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg1, arg2, arg3, arg8);
        let v1 = if (arg6) {
            arg4
        } else {
            arg5
        };
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0, @0x0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, &mut v0, v1, arg6, arg7));
    }

    public fun scale_to_9_decimals(arg0: u64) : u64 {
        arg0 * 1000000000
    }

    public entry fun set_burn_token(arg0: &mut PreLaunchManagerV3, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_is_owner(arg0.creator, 0x2::tx_context::sender(arg2));
        arg0.burn_token = arg1;
    }

    public entry fun set_fee_percentages(arg0: &mut PreLaunchManagerV3, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_is_owner(arg0.creator, 0x2::tx_context::sender(arg4));
        assert!(arg1 + arg2 + arg3 <= 10, 1);
        arg0.platform_fee_percentage = arg1;
        arg0.burn_fee_percentage = arg2;
        arg0.prize_fee_percentage = arg3;
    }

    public entry fun set_fees(arg0: &mut PreLaunchManagerV3, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_is_owner(arg0.creator, 0x2::tx_context::sender(arg4));
        arg0.creation_fee = arg1;
        arg0.sponsorship_fee = arg2;
        arg0.cro_home_fee = arg3;
    }

    public entry fun set_treasury(arg0: &mut PreLaunchManagerV3, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_is_owner(arg0.creator, 0x2::tx_context::sender(arg2));
        arg0.treasury = arg1;
    }

    public entry fun start(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = init_contract(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<PreLaunchManagerV3>(v0, 0x2::tx_context::sender(arg8));
    }

    public entry fun start_round(arg0: &mut PreLaunchManagerV3, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u64>, arg10: vector<u8>, arg11: bool, arg12: &0x2::clock::Clock, arg13: 0x2::coin::Coin<0x2::sui::SUI>, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg13) == arg0.creation_fee, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg13, arg0.treasury);
        let v0 = Round{
            id             : 0x2::object::new(arg14),
            round_id       : (0x1::vector::length<Round>(&arg0.rounds) as u64),
            token_contract : arg2,
            name           : arg1,
            symbol         : arg3,
            total_supply   : 1000000000000000,
            total_raised   : 0,
            hard_cap       : scale_to_9_decimals(arg4),
            end_epoch      : 0x2::clock::timestamp_ms(arg12) / 1000 + arg5 * 60,
            time_frame     : arg5,
            is_finished    : false,
            telegram       : arg6,
            twitter        : arg7,
            website        : arg8,
            description    : arg9,
            imageURL       : arg10,
            sponsored      : arg11,
            creator        : 0x2::tx_context::sender(arg14),
            contributions  : 0x1::vector::empty<RoundUserContribution>(),
        };
        0x1::vector::push_back<Round>(&mut arg0.rounds, v0);
    }

    // decompiled from Move bytecode v6
}

