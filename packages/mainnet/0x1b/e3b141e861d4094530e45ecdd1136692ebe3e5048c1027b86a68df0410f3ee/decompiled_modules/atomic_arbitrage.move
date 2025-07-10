module 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::atomic_arbitrage {
    struct ArbitrageResult has drop {
        initial_amount: u64,
        final_amount: u64,
        profit: u64,
        gas_used: u64,
        dex_a: u8,
        dex_b: u8,
        success: bool,
    }

    struct ArbitrageContext has drop {
        sender: address,
        exact_sui_amount: u64,
        min_profit_threshold: u64,
        max_gas_budget: u64,
        slippage_bps: u64,
    }

    public entry fun arb_aftermath_bluefin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 4, 5, arg1);
    }

    public entry fun arb_aftermath_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 4, 3, arg1);
    }

    public entry fun arb_aftermath_deepbook(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 4, 6, arg1);
    }

    public entry fun arb_aftermath_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 4, 1, arg1);
    }

    public entry fun arb_aftermath_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 4, 2, arg1);
    }

    public entry fun arb_bluefin_aftermath(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 5, 4, arg1);
    }

    public entry fun arb_bluefin_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 5, 3, arg1);
    }

    public entry fun arb_bluefin_deepbook(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 5, 6, arg1);
    }

    public entry fun arb_bluefin_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 5, 1, arg1);
    }

    public entry fun arb_bluefin_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 5, 2, arg1);
    }

    public entry fun arb_cetus_aftermath(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 3, 4, arg1);
    }

    public entry fun arb_cetus_bluefin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 3, 5, arg1);
    }

    public entry fun arb_cetus_deepbook(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 3, 6, arg1);
    }

    public entry fun arb_cetus_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 3, 1, arg1);
    }

    public entry fun arb_cetus_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 3, 2, arg1);
    }

    public entry fun arb_deepbook_aftermath(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 6, 4, arg1);
    }

    public entry fun arb_deepbook_bluefin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 6, 5, arg1);
    }

    public entry fun arb_deepbook_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 6, 3, arg1);
    }

    public entry fun arb_deepbook_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 6, 1, arg1);
    }

    public entry fun arb_deepbook_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 6, 2, arg1);
    }

    public entry fun arb_kriya_aftermath(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 1, 4, arg1);
    }

    public entry fun arb_kriya_bluefin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 1, 5, arg1);
    }

    public entry fun arb_kriya_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 1, 3, arg1);
    }

    public entry fun arb_kriya_deepbook(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 1, 6, arg1);
    }

    public entry fun arb_kriya_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 1, 2, arg1);
    }

    public entry fun arb_turbos_aftermath(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 2, 4, arg1);
    }

    public entry fun arb_turbos_bluefin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 2, 5, arg1);
    }

    public entry fun arb_turbos_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 2, 3, arg1);
    }

    public entry fun arb_turbos_deepbook(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 2, 6, arg1);
    }

    public entry fun arb_turbos_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        atomic_arbitrage_entry(arg0, 2, 1, arg1);
    }

    public entry fun atomic_arbitrage_entry(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = execute_atomic_arbitrage(arg0, arg1, arg2, arg3);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
        assert!(v2.success, 3);
    }

    fun execute_arbitrage_route(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, bool) {
        let v0 = swap_sui_to_wusdc_via_dex(arg0, arg1, arg3);
        (swap_wusdc_to_sui_via_dex(v0, arg2, arg3), true)
    }

    public fun execute_atomic_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, ArbitrageResult) {
        assert!(0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::is_valid_dex_id(arg1), 4);
        assert!(0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::is_valid_dex_id(arg2), 4);
        assert!(arg1 != arg2, 4);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 == 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(), 1);
        let (v1, _) = execute_arbitrage_route(arg0, arg1, arg2, arg3);
        let v3 = v1;
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        let v6 = ArbitrageResult{
            initial_amount : v0,
            final_amount   : v4,
            profit         : v5,
            gas_used       : 0,
            dex_a          : arg1,
            dex_b          : arg2,
            success        : v4 >= v0,
        };
        (v3, v6)
    }

    public fun get_arbitrage_result_details(arg0: &ArbitrageResult) : (u64, u64, u64, u8, u8, bool) {
        (arg0.initial_amount, arg0.final_amount, arg0.profit, arg0.dex_a, arg0.dex_b, arg0.success)
    }

    public fun get_sui_type() : vector<u8> {
        0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_sui_type()
    }

    public fun get_wusdc_type() : vector<u8> {
        0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_wusdc_type()
    }

    public fun init_arbitrage_context(arg0: &mut 0x2::tx_context::TxContext) : ArbitrageContext {
        ArbitrageContext{
            sender               : 0x2::tx_context::sender(arg0),
            exact_sui_amount     : 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_exact_sui_amount(),
            min_profit_threshold : 1000,
            max_gas_budget       : 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_default_gas_budget(),
            slippage_bps         : 0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::constants::get_default_slippage_bps(),
        }
    }

    public fun is_arbitrage_profitable(arg0: &ArbitrageResult, arg1: u64) : bool {
        arg0.success && arg0.profit >= arg1
    }

    fun swap_sui_to_wusdc_via_dex(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::wusdc::WUSDC> {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0) > 0, 2);
        if (arg1 == 1) {
            0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::dex_kriya::swap_sui_to_wusdc(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2), arg2)
        } else if (arg1 == 2) {
            0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::dex_turbos::swap_sui_to_wusdc(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2), arg2)
        } else if (arg1 == 3) {
            0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::dex_cetus::swap_sui_to_wusdc(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2), arg2)
        } else if (arg1 == 4) {
            0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::dex_aftermath::swap_sui_to_wusdc(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2), arg2)
        } else if (arg1 == 5) {
            0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::dex_bluefin::swap_sui_to_wusdc(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2), arg2)
        } else {
            assert!(arg1 == 6, 4);
            0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::dex_deepbook::swap_sui_to_wusdc(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2), arg2)
        }
    }

    fun swap_wusdc_to_sui_via_dex(arg0: 0x2::coin::Coin<0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::wusdc::WUSDC>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::into_balance<0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::wusdc::WUSDC>(arg0);
        assert!(0x2::balance::value<0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::wusdc::WUSDC>(&v0) > 0, 2);
        if (arg1 == 1) {
            0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::dex_kriya::swap_wusdc_to_sui(0x2::coin::from_balance<0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::wusdc::WUSDC>(v0, arg2), arg2)
        } else if (arg1 == 2) {
            0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::dex_turbos::swap_wusdc_to_sui(0x2::coin::from_balance<0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::wusdc::WUSDC>(v0, arg2), arg2)
        } else if (arg1 == 3) {
            0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::dex_cetus::swap_wusdc_to_sui(0x2::coin::from_balance<0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::wusdc::WUSDC>(v0, arg2), arg2)
        } else if (arg1 == 4) {
            0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::dex_aftermath::swap_wusdc_to_sui(0x2::coin::from_balance<0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::wusdc::WUSDC>(v0, arg2), arg2)
        } else if (arg1 == 5) {
            0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::dex_bluefin::swap_wusdc_to_sui(0x2::coin::from_balance<0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::wusdc::WUSDC>(v0, arg2), arg2)
        } else {
            assert!(arg1 == 6, 4);
            0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::dex_deepbook::swap_wusdc_to_sui(0x2::coin::from_balance<0x1be3b141e861d4094530e45ecdd1136692ebe3e5048c1027b86a68df0410f3ee::wusdc::WUSDC>(v0, arg2), arg2)
        }
    }

    // decompiled from Move bytecode v6
}

