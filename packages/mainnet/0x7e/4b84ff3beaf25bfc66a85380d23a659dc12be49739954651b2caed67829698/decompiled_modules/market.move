module 0x7e4b84ff3beaf25bfc66a85380d23a659dc12be49739954651b2caed67829698::market {
    struct ManagerCap has key {
        id: 0x2::object::UID,
    }

    struct MARKET has drop {
        dummy_field: bool,
    }

    struct MarketConfig has store {
        total_1: u64,
        total_2: u64,
        total_3: u64,
        total_4: u64,
        probability_1: u64,
        probability_2: u64,
        probability_3: u64,
        probability_4: u64,
        ratio: u64,
        resolved: bool,
        winning_outcome: u8,
        expiration: u64,
    }

    struct Position has store {
        holder: address,
        market_type: u8,
        placing_odds: u64,
        amount: u64,
        predicted_outcome: u8,
        round: u64,
        epoch: u64,
        is_open: bool,
    }

    struct LiquidityPool has store {
        used_bet_amount: u64,
        lp_supply: 0x2::balance::Supply<MARKET>,
        min_liquidity: 0x2::balance::Balance<MARKET>,
        vault_balance: 0x2::balance::Balance<0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VAULT>,
        min_amount: u64,
    }

    struct Request has drop, store {
        sender: address,
        amount: u64,
        epoch: u64,
    }

    struct MarketGlobal has key {
        id: 0x2::object::UID,
        admin_list: vector<address>,
        market_btc: 0x2::table::Table<u64, MarketConfig>,
        market_sui: 0x2::table::Table<u64, MarketConfig>,
        market_custom: 0x2::table::Table<u64, MarketConfig>,
        current_round: u64,
        positions: 0x2::table::Table<u64, Position>,
        liquidity_pool: LiquidityPool,
        commission_fee: u64,
        reserve_ratio: u64,
        weight: u64,
        max_bet_amount: u64,
        max_odds: u64,
        treasury_address: address,
        is_paused: bool,
        pending_fulfil: 0x2::balance::Balance<0x2::sui::SUI>,
        request_list: 0x2::table_vec::TableVec<Request>,
        max_capacity: u64,
        total_vault_locked: u64,
        current_staking_amount: u64,
        current_fulfil_amount: u64,
    }

    struct AddMarketEvent has copy, drop {
        global: 0x2::object::ID,
        round: u64,
        market_type: u8,
        probability_1: u64,
        probability_2: u64,
        probability_3: u64,
        probability_4: u64,
        ratio: u64,
        expiration: u64,
        epoch: u64,
        sender: address,
    }

    struct UpdateMarketEvent has copy, drop {
        global: 0x2::object::ID,
        round: u64,
        market_type: u8,
        probability_1: u64,
        probability_2: u64,
        probability_3: u64,
        probability_4: u64,
        ratio: u64,
        epoch: u64,
        sender: address,
    }

    struct ResolveMarketEvent has copy, drop {
        global: 0x2::object::ID,
        round: u64,
        market_type: u8,
        winning_outcome: u8,
        epoch: u64,
        sender: address,
    }

    struct AddLiquidityEvent has copy, drop {
        global: 0x2::object::ID,
        deposit_amount: u64,
        lp_amount: u64,
        epoch: u64,
        sender: address,
    }

    struct RequestWithdrawEvent has copy, drop {
        global: 0x2::object::ID,
        lp_amount: u64,
        withdraw_amount: u64,
        epoch: u64,
        sender: address,
    }

    struct Redeem has copy, drop {
        global: 0x2::object::ID,
        withdraw_amount: u64,
        epoch: u64,
        sender: address,
    }

    struct PlaceBetEvent has copy, drop {
        global: 0x2::object::ID,
        round: u64,
        market_type: u8,
        bet_outcome: u8,
        bet_amount: u64,
        placing_odds: u64,
        position_id: u64,
        epoch: u64,
        sender: address,
    }

    struct PayoutWinnersEvent has copy, drop {
        global: 0x2::object::ID,
        round: u64,
        market_type: u8,
        from_id: u64,
        until_id: u64,
        total_winners: u64,
        total_payout_amount: u64,
        epoch: u64,
        sender: address,
    }

    public entry fun add_admin(arg0: &mut MarketGlobal, arg1: &mut ManagerCap, arg2: address) {
        let (v0, _) = 0x1::vector::index_of<address>(&arg0.admin_list, &arg2);
        assert!(v0 == false, 6);
        0x1::vector::push_back<address>(&mut arg0.admin_list, arg2);
    }

    public entry fun add_market(arg0: &mut MarketGlobal, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, 0x2::tx_context::sender(arg8));
        assert!(arg1 > 0, 2);
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v0, 2);
        assert!(arg7 >= 0x2::tx_context::epoch(arg8), 2);
        assert!(arg3 + arg4 + arg5 + arg6 == 10000, 2);
        let v1 = MarketConfig{
            total_1         : 0,
            total_2         : 0,
            total_3         : 0,
            total_4         : 0,
            probability_1   : arg3,
            probability_2   : arg4,
            probability_3   : arg5,
            probability_4   : arg6,
            ratio           : 17500,
            resolved        : false,
            winning_outcome : 0,
            expiration      : arg7,
        };
        if (arg2 == 0) {
            assert!(0x2::table::contains<u64, MarketConfig>(&arg0.market_btc, arg1) == false, 6);
            0x2::table::add<u64, MarketConfig>(&mut arg0.market_btc, arg1, v1);
        } else if (arg2 == 1) {
            assert!(0x2::table::contains<u64, MarketConfig>(&arg0.market_sui, arg1) == false, 6);
            0x2::table::add<u64, MarketConfig>(&mut arg0.market_sui, arg1, v1);
        } else {
            assert!(0x2::table::contains<u64, MarketConfig>(&arg0.market_custom, arg1) == false, 6);
            0x2::table::add<u64, MarketConfig>(&mut arg0.market_custom, arg1, v1);
        };
        if (arg1 > arg0.current_round) {
            arg0.current_round = arg1;
        };
        let v2 = AddMarketEvent{
            global        : 0x2::object::id<MarketGlobal>(arg0),
            round         : arg1,
            market_type   : arg2,
            probability_1 : arg3,
            probability_2 : arg4,
            probability_3 : arg5,
            probability_4 : arg6,
            ratio         : 17500,
            expiration    : arg7,
            epoch         : 0x2::tx_context::epoch(arg8),
            sender        : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<AddMarketEvent>(v2);
    }

    public entry fun available_for_immediate_payout(arg0: &MarketGlobal) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pending_fulfil)
    }

    fun calculate_odds(arg0: u64, arg1: u64) : u64 {
        let v0 = 100000000 / arg0;
        if (v0 >= arg1) {
            arg1
        } else {
            v0
        }
    }

    fun calculate_p_adjusted(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg2 != 0 || arg3 != 0) {
            (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::multiply_u128(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::multiply_u128((arg0 as u128), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((arg1 as u128), 10000)) + 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::multiply_u128(((10000 - arg1) as u128), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((arg2 as u128), (arg3 as u128))), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((arg4 as u128), 10000)) as u64)
        } else {
            arg0
        }
    }

    public entry fun check_betting_capacity(arg0: &MarketGlobal) : u64 {
        arg0.max_capacity
    }

    public entry fun check_payout_amount(arg0: &MarketGlobal, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let (_, v1, _) = list_winners_and_payouts(arg0, arg1, arg2, arg3, arg4, arg5);
        let v3 = v1;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x1::vector::length<u64>(&v3);
        while (v5 < v6) {
            v4 = v4 + *0x1::vector::borrow<u64>(&v3, v5);
            v5 = v5 + 1;
        };
        (v6, v4)
    }

    public entry fun fulfil_request(arg0: &mut MarketGlobal, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table_vec::length<Request>(&arg0.request_list) > 0, 15);
        while (0x2::table_vec::length<Request>(&arg0.request_list) > 0) {
            let v0 = 0x2::table_vec::pop_back<Request>(&mut arg0.request_list);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_fulfil, v0.amount), arg1), v0.sender);
            let v1 = Redeem{
                global          : 0x2::object::id<MarketGlobal>(arg0),
                withdraw_amount : v0.amount,
                epoch           : 0x2::tx_context::epoch(arg1),
                sender          : v0.sender,
            };
            0x2::event::emit<Redeem>(v1);
        };
    }

    public entry fun get_bet_position(arg0: &MarketGlobal, arg1: u64) : (u8, u64, u64, u8, u64, u64, bool) {
        let v0 = 0x2::table::borrow<u64, Position>(&arg0.positions, arg1);
        (v0.market_type, v0.placing_odds, v0.amount, v0.predicted_outcome, v0.round, v0.epoch, v0.is_open)
    }

    public entry fun get_bet_position_ids(arg0: &MarketGlobal, arg1: u8, arg2: address) : vector<u64> {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg1 == 1) {
            true
        } else {
            arg1 == 2
        };
        assert!(v0, 2);
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        while (v1 < 0x2::table::length<u64, Position>(&arg0.positions)) {
            let v3 = 0x2::table::borrow<u64, Position>(&arg0.positions, v1);
            if (arg1 == v3.market_type && arg2 == v3.holder) {
                0x1::vector::push_back<u64>(&mut v2, v1);
            };
            v1 = v1 + 1;
        };
        v2
    }

    public entry fun get_current_round(arg0: &MarketGlobal) : u64 {
        arg0.current_round
    }

    fun get_current_staking_amount(arg0: &0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VaultGlobal, arg1: u64) : u64 {
        let (v0, v1) = 0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::get_amounts(arg0);
        (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::multiply_u128((v0 as u128), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((arg1 as u128), (v1 as u128))) as u64)
    }

    public entry fun get_market_adjusted_probabilities(arg0: &MarketGlobal, arg1: u64, arg2: u8) : vector<u64> {
        let (v0, v1, _, _, _, v5, v6) = get_market_info_internal(arg0, arg1, arg2);
        let v7 = v1;
        let v8 = v0;
        let v9 = 0x1::vector::empty<u64>();
        let v10 = 0;
        while (v10 < 4) {
            0x1::vector::push_back<u64>(&mut v9, calculate_p_adjusted(*0x1::vector::borrow<u64>(&v7, v10), arg0.weight, *0x1::vector::borrow<u64>(&v8, v10), v6, v5));
            v10 = v10 + 1;
        };
        v9
    }

    public entry fun get_market_info(arg0: &MarketGlobal, arg1: u64, arg2: u8) : (vector<u64>, vector<u64>, bool, u8, u64, u64, u64) {
        get_market_info_internal(arg0, arg1, arg2)
    }

    fun get_market_info_internal(arg0: &MarketGlobal, arg1: u64, arg2: u8) : (vector<u64>, vector<u64>, bool, u8, u64, u64, u64) {
        assert!(arg1 > 0, 2);
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v0, 2);
        let v1 = if (arg2 == 0) {
            assert!(0x2::table::contains<u64, MarketConfig>(&arg0.market_btc, arg1), 3);
            0x2::table::borrow<u64, MarketConfig>(&arg0.market_btc, arg1)
        } else if (arg2 == 1) {
            assert!(0x2::table::contains<u64, MarketConfig>(&arg0.market_sui, arg1), 3);
            0x2::table::borrow<u64, MarketConfig>(&arg0.market_sui, arg1)
        } else {
            assert!(0x2::table::contains<u64, MarketConfig>(&arg0.market_custom, arg1), 3);
            0x2::table::borrow<u64, MarketConfig>(&arg0.market_custom, arg1)
        };
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, v1.total_1);
        0x1::vector::push_back<u64>(&mut v2, v1.total_2);
        0x1::vector::push_back<u64>(&mut v2, v1.total_3);
        0x1::vector::push_back<u64>(&mut v2, v1.total_4);
        0x1::vector::push_back<u64>(&mut v3, v1.probability_1);
        0x1::vector::push_back<u64>(&mut v3, v1.probability_2);
        0x1::vector::push_back<u64>(&mut v3, v1.probability_3);
        0x1::vector::push_back<u64>(&mut v3, v1.probability_4);
        (v2, v3, v1.resolved, v1.winning_outcome, v1.expiration, v1.ratio, v1.total_1 + v1.total_2 + v1.total_3 + v1.total_4)
    }

    public entry fun get_total_vault_balance(arg0: &MarketGlobal, arg1: &0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VaultGlobal) : u64 {
        get_current_staking_amount(arg1, 0x2::balance::value<0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VAULT>(&arg0.liquidity_pool.vault_balance)) + 0x2::balance::value<0x2::sui::SUI>(&arg0.pending_fulfil)
    }

    public entry fun get_total_vault_locked(arg0: &MarketGlobal) : u64 {
        0x2::balance::value<0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VAULT>(&arg0.liquidity_pool.vault_balance)
    }

    fun init(arg0: MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ManagerCap>(v0, 0x2::tx_context::sender(arg1));
        let (v1, v2) = 0x2::coin::create_currency<MARKET>(arg0, 9, b"MARKET", b"Legato Market Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.tamago.finance/legato-logo-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARKET>>(v2);
        let v3 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v3, 0x2::tx_context::sender(arg1));
        let v4 = LiquidityPool{
            used_bet_amount : 0,
            lp_supply       : 0x2::coin::treasury_into_supply<MARKET>(v1),
            min_liquidity   : 0x2::balance::zero<MARKET>(),
            vault_balance   : 0x2::balance::zero<0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VAULT>(),
            min_amount      : 100000000,
        };
        let v5 = MarketGlobal{
            id                     : 0x2::object::new(arg1),
            admin_list             : v3,
            market_btc             : 0x2::table::new<u64, MarketConfig>(arg1),
            market_sui             : 0x2::table::new<u64, MarketConfig>(arg1),
            market_custom          : 0x2::table::new<u64, MarketConfig>(arg1),
            current_round          : 0,
            positions              : 0x2::table::new<u64, Position>(arg1),
            liquidity_pool         : v4,
            commission_fee         : 1000,
            reserve_ratio          : 8000,
            weight                 : 7000,
            max_bet_amount         : 1000000000,
            max_odds               : 80000,
            treasury_address       : 0x2::tx_context::sender(arg1),
            is_paused              : false,
            pending_fulfil         : 0x2::balance::zero<0x2::sui::SUI>(),
            request_list           : 0x2::table_vec::empty<Request>(arg1),
            max_capacity           : 0,
            total_vault_locked     : 0,
            current_staking_amount : 0,
            current_fulfil_amount  : 0,
        };
        0x2::transfer::share_object<MarketGlobal>(v5);
    }

    fun list_winners_and_payouts(arg0: &MarketGlobal, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) : (vector<address>, vector<u64>, vector<u64>) {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v0, 2);
        assert!(arg4 > arg3, 2);
        let v1 = if (arg2 == 0) {
            assert!(0x2::table::contains<u64, MarketConfig>(&arg0.market_btc, arg1), 3);
            0x2::table::borrow<u64, MarketConfig>(&arg0.market_btc, arg1)
        } else if (arg2 == 1) {
            assert!(0x2::table::contains<u64, MarketConfig>(&arg0.market_sui, arg1), 3);
            0x2::table::borrow<u64, MarketConfig>(&arg0.market_sui, arg1)
        } else {
            assert!(0x2::table::contains<u64, MarketConfig>(&arg0.market_custom, arg1), 3);
            0x2::table::borrow<u64, MarketConfig>(&arg0.market_custom, arg1)
        };
        assert!(v1.resolved == true, 4);
        let v2 = if (arg4 > 0x2::table::length<u64, Position>(&arg0.positions)) {
            0x2::table::length<u64, Position>(&arg0.positions)
        } else {
            arg4
        };
        let v3 = 0x1::vector::empty<address>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        while (arg3 < v2) {
            let v6 = 0x2::table::borrow<u64, Position>(&arg0.positions, arg3);
            let v7 = if (v6.is_open == true) {
                if (v6.round == arg1) {
                    if (v6.market_type == arg2) {
                        0x2::tx_context::epoch(arg5) > v1.expiration
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v7) {
                0x1::vector::push_back<u64>(&mut v5, arg3);
                if (v6.predicted_outcome == v1.winning_outcome) {
                    if (0x1::vector::contains<address>(&v3, &v6.holder)) {
                        let (_, v9) = 0x1::vector::index_of<address>(&v3, &v6.holder);
                        *0x1::vector::borrow_mut<u64>(&mut v4, v9) = *0x1::vector::borrow<u64>(&v4, v9) + (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::multiply_u128((v6.amount as u128), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((v6.placing_odds as u128), 10000)) as u64);
                    } else {
                        0x1::vector::push_back<address>(&mut v3, v6.holder);
                        0x1::vector::push_back<u64>(&mut v4, (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::multiply_u128((v6.amount as u128), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((v6.placing_odds as u128), 10000)) as u64));
                    };
                };
            };
            arg3 = arg3 + 1;
        };
        (v3, v4, v5)
    }

    public entry fun manual_set_capacity(arg0: &mut MarketGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 > 0, 8);
        arg0.max_capacity = arg1;
    }

    public entry fun pause(arg0: &mut MarketGlobal, arg1: &mut ManagerCap, arg2: bool) {
        arg0.is_paused = arg2;
    }

    public entry fun payout_winners(arg0: &mut MarketGlobal, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = list_winners_and_payouts(arg0, arg1, arg2, arg3, arg4, arg5);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0;
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&v4)) {
            v6 = v6 + *0x1::vector::borrow<u64>(&v4, v7);
            v7 = v7 + 1;
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.pending_fulfil) >= v6, 16);
        v7 = 0;
        let v8 = 0;
        while (v7 < 0x1::vector::length<address>(&v5)) {
            let v9 = *0x1::vector::borrow<u64>(&v4, v7);
            let v10 = (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::multiply_u128((v9 as u128), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((arg0.commission_fee as u128), 10000)) as u64);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_fulfil, v9 - v10), arg5), *0x1::vector::borrow<address>(&v5, v7));
            v8 = v8 + v10;
            v7 = v7 + 1;
        };
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_fulfil, v8), arg5), arg0.treasury_address);
        };
        let v11 = 0;
        while (0x1::vector::length<u64>(&v3) > 0) {
            let v12 = 0x2::table::borrow_mut<u64, Position>(&mut arg0.positions, 0x1::vector::pop_back<u64>(&mut v3));
            v11 = v11 + v12.amount;
            v12.is_open = false;
        };
        let v13 = if (arg0.liquidity_pool.used_bet_amount > v11) {
            arg0.liquidity_pool.used_bet_amount - v11
        } else {
            0
        };
        arg0.liquidity_pool.used_bet_amount = v13;
        let v14 = PayoutWinnersEvent{
            global              : 0x2::object::id<MarketGlobal>(arg0),
            round               : arg1,
            market_type         : arg2,
            from_id             : arg3,
            until_id            : arg4,
            total_winners       : 0x1::vector::length<address>(&v5),
            total_payout_amount : v6,
            epoch               : 0x2::tx_context::epoch(arg5),
            sender              : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<PayoutWinnersEvent>(v14);
    }

    public entry fun place_bet(arg0: &mut MarketGlobal, arg1: &mut 0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VaultGlobal, arg2: u64, arg3: u8, arg4: u8, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(arg0.is_paused == false, 9);
        let v1 = if (arg3 == 0) {
            true
        } else if (arg3 == 1) {
            true
        } else {
            arg3 == 2
        };
        assert!(v1, 2);
        assert!(arg4 > 0 && arg4 <= 4, 2);
        assert!(arg0.max_bet_amount >= v0, 12);
        assert!(arg0.max_capacity >= v0, 13);
        let v2 = if (arg3 == 0) {
            assert!(0x2::table::contains<u64, MarketConfig>(&arg0.market_btc, arg2), 3);
            0x2::table::borrow_mut<u64, MarketConfig>(&mut arg0.market_btc, arg2)
        } else if (arg3 == 1) {
            assert!(0x2::table::contains<u64, MarketConfig>(&arg0.market_sui, arg2), 3);
            0x2::table::borrow_mut<u64, MarketConfig>(&mut arg0.market_sui, arg2)
        } else {
            assert!(0x2::table::contains<u64, MarketConfig>(&arg0.market_custom, arg2), 3);
            0x2::table::borrow_mut<u64, MarketConfig>(&mut arg0.market_custom, arg2)
        };
        assert!(v2.expiration > 0x2::tx_context::epoch(arg6), 14);
        assert!(v2.resolved == false, 7);
        let (v3, v4) = update_market_outcomes(v2, arg4, v0);
        let v5 = calculate_odds(calculate_p_adjusted(v4, arg0.weight, v3, total_outcomes(v2), v2.ratio), arg0.max_odds);
        let v6 = Position{
            holder            : 0x2::tx_context::sender(arg6),
            market_type       : arg3,
            placing_odds      : v5,
            amount            : v0,
            predicted_outcome : arg4,
            round             : arg2,
            epoch             : 0x2::tx_context::epoch(arg6),
            is_open           : true,
        };
        let v7 = 0x2::table::length<u64, Position>(&arg0.positions);
        0x2::table::add<u64, Position>(&mut arg0.positions, v7, v6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_fulfil, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        arg0.liquidity_pool.used_bet_amount = arg0.liquidity_pool.used_bet_amount + v0;
        update(arg0, arg1);
        let v8 = PlaceBetEvent{
            global       : 0x2::object::id<MarketGlobal>(arg0),
            round        : arg2,
            market_type  : arg3,
            bet_outcome  : arg4,
            bet_amount   : v0,
            placing_odds : v5,
            position_id  : v7,
            epoch        : 0x2::tx_context::epoch(arg6),
            sender       : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<PlaceBetEvent>(v8);
    }

    public entry fun provide(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut MarketGlobal, arg2: &mut 0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VaultGlobal, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(arg1.is_paused == false, 9);
        assert!(v0 >= arg1.liquidity_pool.min_amount, 10);
        let v1 = 0x2::balance::supply_value<MARKET>(&arg1.liquidity_pool.lp_supply);
        let v2 = if (v1 == 0) {
            assert!(v0 > 1000, 11);
            0x2::balance::join<MARKET>(&mut arg1.liquidity_pool.min_liquidity, 0x2::balance::increase_supply<MARKET>(&mut arg1.liquidity_pool.lp_supply, 1000));
            v0 - 1000
        } else {
            (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::multiply_u128((v1 as u128), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((v0 as u128), ((get_current_staking_amount(arg2, 0x2::balance::value<0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VAULT>(&arg1.liquidity_pool.vault_balance)) + 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_fulfil)) as u128))) as u64)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<MARKET>>(0x2::coin::from_balance<MARKET>(0x2::balance::increase_supply<MARKET>(&mut arg1.liquidity_pool.lp_supply, v2), arg4), 0x2::tx_context::sender(arg4));
        0x2::balance::join<0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VAULT>(&mut arg1.liquidity_pool.vault_balance, 0x2::coin::into_balance<0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VAULT>(0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::mint_non_entry(arg0, arg2, arg3, arg4)));
        update(arg1, arg2);
        let v3 = AddLiquidityEvent{
            global         : 0x2::object::id<MarketGlobal>(arg1),
            deposit_amount : v0,
            lp_amount      : v2,
            epoch          : 0x2::tx_context::epoch(arg4),
            sender         : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<AddLiquidityEvent>(v3);
    }

    public entry fun remove_admin(arg0: &mut MarketGlobal, arg1: &mut ManagerCap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admin_list, &arg2);
        assert!(v0 == true, 3);
        0x1::vector::swap_remove<address>(&mut arg0.admin_list, v1);
    }

    public entry fun request_unstake_sui_from_legato_vault(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut MarketGlobal, arg2: &mut 0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VaultGlobal, arg3: &mut ManagerCap, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 8);
        let v0 = 0x2::balance::value<0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VAULT>(&arg1.liquidity_pool.vault_balance);
        let v1 = get_current_staking_amount(arg2, v0) + 0x2::balance::value<0x2::sui::SUI>(&arg1.pending_fulfil);
        assert!(v1 >= arg4, 11);
        0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::request_redeem(arg0, arg2, 0x2::coin::from_balance<0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VAULT>(0x2::balance::split<0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VAULT>(&mut arg1.liquidity_pool.vault_balance, (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::multiply_u128((v0 as u128), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((arg4 as u128), (v1 as u128))) as u64)), arg5), arg5);
        update(arg1, arg2);
    }

    public entry fun request_withdraw(arg0: &mut MarketGlobal, arg1: &mut 0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VaultGlobal, arg2: 0x2::coin::Coin<MARKET>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<MARKET>(&arg2);
        assert!(arg0.is_paused == false, 9);
        assert!(v0 >= arg0.liquidity_pool.min_amount, 10);
        let v1 = (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::multiply_u128(((get_current_staking_amount(arg1, 0x2::balance::value<0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VAULT>(&arg0.liquidity_pool.vault_balance)) + 0x2::balance::value<0x2::sui::SUI>(&arg0.pending_fulfil)) as u128), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((v0 as u128), (0x2::balance::supply_value<MARKET>(&arg0.liquidity_pool.lp_supply) as u128))) as u64);
        let v2 = Request{
            sender : 0x2::tx_context::sender(arg3),
            amount : v1,
            epoch  : 0x2::tx_context::epoch(arg3),
        };
        0x2::table_vec::push_back<Request>(&mut arg0.request_list, v2);
        0x2::balance::decrease_supply<MARKET>(&mut arg0.liquidity_pool.lp_supply, 0x2::coin::into_balance<MARKET>(arg2));
        update(arg0, arg1);
        let v3 = RequestWithdrawEvent{
            global          : 0x2::object::id<MarketGlobal>(arg0),
            lp_amount       : v0,
            withdraw_amount : v1,
            epoch           : 0x2::tx_context::epoch(arg3),
            sender          : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RequestWithdrawEvent>(v3);
    }

    public entry fun resolve_market(arg0: &mut MarketGlobal, arg1: u64, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg1 > 0, 2);
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v0, 2);
        assert!(arg3 > 0, 2);
        let v1 = if (arg2 == 0) {
            assert!(0x2::table::contains<u64, MarketConfig>(&arg0.market_btc, arg1), 3);
            0x2::table::borrow_mut<u64, MarketConfig>(&mut arg0.market_btc, arg1)
        } else if (arg2 == 1) {
            assert!(0x2::table::contains<u64, MarketConfig>(&arg0.market_sui, arg1), 3);
            0x2::table::borrow_mut<u64, MarketConfig>(&mut arg0.market_sui, arg1)
        } else {
            assert!(0x2::table::contains<u64, MarketConfig>(&arg0.market_custom, arg1), 3);
            0x2::table::borrow_mut<u64, MarketConfig>(&mut arg0.market_custom, arg1)
        };
        assert!(v1.resolved == false, 7);
        v1.resolved = true;
        v1.winning_outcome = arg3;
        let v2 = ResolveMarketEvent{
            global          : 0x2::object::id<MarketGlobal>(arg0),
            round           : arg1,
            market_type     : arg2,
            winning_outcome : arg3,
            epoch           : 0x2::tx_context::epoch(arg4),
            sender          : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ResolveMarketEvent>(v2);
    }

    public entry fun set_market_probabilities(arg0: &mut MarketGlobal, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, 0x2::tx_context::sender(arg8));
        assert!(arg1 > 0, 2);
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v0, 2);
        assert!(arg3 + arg4 + arg5 + arg7 == 10000, 2);
        let v1 = if (arg2 == 0) {
            assert!(0x2::table::contains<u64, MarketConfig>(&arg0.market_btc, arg1), 3);
            0x2::table::borrow_mut<u64, MarketConfig>(&mut arg0.market_btc, arg1)
        } else if (arg2 == 1) {
            assert!(0x2::table::contains<u64, MarketConfig>(&arg0.market_sui, arg1), 3);
            0x2::table::borrow_mut<u64, MarketConfig>(&mut arg0.market_sui, arg1)
        } else {
            assert!(0x2::table::contains<u64, MarketConfig>(&arg0.market_custom, arg1), 3);
            0x2::table::borrow_mut<u64, MarketConfig>(&mut arg0.market_custom, arg1)
        };
        v1.probability_1 = arg3;
        v1.probability_2 = arg4;
        v1.probability_3 = arg5;
        v1.probability_4 = arg7;
        v1.ratio = arg6;
        let v2 = UpdateMarketEvent{
            global        : 0x2::object::id<MarketGlobal>(arg0),
            round         : arg1,
            market_type   : arg2,
            probability_1 : arg3,
            probability_2 : arg4,
            probability_3 : arg5,
            probability_4 : arg7,
            ratio         : arg6,
            epoch         : 0x2::tx_context::epoch(arg8),
            sender        : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<UpdateMarketEvent>(v2);
    }

    public entry fun stake_locked_sui_to_legato_vault(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut MarketGlobal, arg2: &mut 0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VaultGlobal, arg3: &mut ManagerCap, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 8);
        0x2::balance::join<0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VAULT>(&mut arg1.liquidity_pool.vault_balance, 0x2::coin::into_balance<0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VAULT>(0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::mint_non_entry(arg0, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.pending_fulfil, arg4), arg5), arg5)));
        update(arg1, arg2);
    }

    public entry fun topup_fulfilment_pool(arg0: &mut MarketGlobal, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_fulfil, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun total_bet_positions(arg0: &MarketGlobal) : u64 {
        0x2::table::length<u64, Position>(&arg0.positions)
    }

    fun total_outcomes(arg0: &MarketConfig) : u64 {
        arg0.total_1 + arg0.total_2 + arg0.total_3 + arg0.total_4
    }

    public entry fun update(arg0: &mut MarketGlobal, arg1: &mut 0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VaultGlobal) {
        update_capacity(arg0, arg1);
    }

    public fun update_capacity(arg0: &mut MarketGlobal, arg1: &mut 0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VaultGlobal) {
        let v0 = 0x2::balance::value<0xd3b4dc330793d2297e1136b75ec457666d2ca436743e7fdffa6fa1c81bf63c74::vault::VAULT>(&arg0.liquidity_pool.vault_balance);
        let v1 = get_current_staking_amount(arg1, v0);
        let v2 = (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::multiply_u128(((v1 + 0x2::balance::value<0x2::sui::SUI>(&arg0.pending_fulfil)) as u128), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((arg0.reserve_ratio as u128), 10000)) as u64);
        let v3 = if (v2 > arg0.liquidity_pool.used_bet_amount) {
            v2 - arg0.liquidity_pool.used_bet_amount
        } else {
            0
        };
        arg0.max_capacity = v3;
        arg0.total_vault_locked = v0;
        arg0.current_staking_amount = v1;
        arg0.current_fulfil_amount = 0x2::balance::value<0x2::sui::SUI>(&arg0.pending_fulfil);
    }

    public entry fun update_commission_fee(arg0: &mut MarketGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 > 0 && arg1 <= 4000, 2);
        arg0.commission_fee = arg1;
    }

    fun update_market_outcomes(arg0: &mut MarketConfig, arg1: u8, arg2: u64) : (u64, u64) {
        if (arg1 == 1) {
            assert!(arg0.probability_1 != 0, 5);
            arg0.total_1 = arg0.total_1 + arg2;
            (arg0.total_1, arg0.probability_1)
        } else if (arg1 == 2) {
            assert!(arg0.probability_2 != 0, 5);
            arg0.total_2 = arg0.total_2 + arg2;
            (arg0.total_2, arg0.probability_2)
        } else if (arg1 == 3) {
            assert!(arg0.probability_3 != 0, 5);
            arg0.total_3 = arg0.total_3 + arg2;
            (arg0.total_3, arg0.probability_3)
        } else {
            assert!(arg0.probability_4 != 0, 5);
            arg0.total_4 = arg0.total_4 + arg2;
            (arg0.total_4, arg0.probability_4)
        }
    }

    public entry fun update_max_bet_amount(arg0: &mut MarketGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 > 0, 8);
        arg0.max_bet_amount = arg1;
    }

    public entry fun update_min_amount(arg0: &mut MarketGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 > 0, 8);
        arg0.liquidity_pool.min_amount = arg1;
    }

    public entry fun update_odds_cap(arg0: &mut MarketGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 >= 10000, 8);
        arg0.max_odds = arg1;
    }

    public entry fun update_reserve_ratio(arg0: &mut MarketGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 > 0 && arg1 <= 100000, 2);
        arg0.reserve_ratio = arg1;
    }

    public entry fun update_round(arg0: &mut MarketGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, 0x2::tx_context::sender(arg2));
        arg0.current_round = arg1;
    }

    public entry fun update_treasury_adddress(arg0: &mut MarketGlobal, arg1: &mut ManagerCap, arg2: address) {
        arg0.treasury_address = arg2;
    }

    public entry fun update_weight(arg0: &mut MarketGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 > 0 && arg1 <= 10000, 2);
        arg0.weight = arg1;
    }

    fun verify_admin(arg0: &MarketGlobal, arg1: address) {
        let (v0, _) = 0x1::vector::index_of<address>(&arg0.admin_list, &arg1);
        assert!(v0, 1);
    }

    public entry fun withdraw_fulfilment_pool(arg0: &mut MarketGlobal, arg1: &mut ManagerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_fulfil, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

