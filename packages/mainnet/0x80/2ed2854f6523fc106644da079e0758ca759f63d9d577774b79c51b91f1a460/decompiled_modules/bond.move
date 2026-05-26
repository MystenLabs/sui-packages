module 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::bond {
    struct BondMarket<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        payout_balance: 0x2::balance::Balance<T0>,
        payout_decimals: u8,
        principal_decimals: u8,
        treasury_id: address,
        fee_in_principal_recipient: address,
        fee_in_payout_recipient: address,
        terms: BondTerms,
        fee_in_principal: u64,
        fee_in_payout: u64,
        total_principal_billed: u128,
        total_payout_given: u128,
        payout_token_initial_supply: u64,
        total_debt: u128,
        last_decay: u64,
        last_bcv_update_timestamp: u64,
        min_bcv_update_interval: u64,
        owner: address,
        operators: 0x2::vec_map::VecMap<address, bool>,
        paused: bool,
        emergency_paused: bool,
        bills: 0x2::table::Table<u64, Bill>,
        redeemer_approved: 0x2::table::Table<address, 0x2::vec_map::VecMap<address, bool>>,
        name: vector<u8>,
        vesting_config: 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::curve::VestingConfig,
    }

    struct BondTerms has copy, drop, store {
        control_variable: u64,
        vesting_term: u64,
        minimum_price: u64,
        max_payout: u64,
        max_debt: u128,
        max_total_payout: u128,
        initial_debt: u128,
    }

    struct Bill has copy, drop, store {
        payout: u64,
        payout_claimed: u64,
        vesting_term: u64,
        vesting_start_timestamp: u64,
        last_claim_timestamp: u64,
        true_price_paid: u64,
    }

    struct MarketCreateEvent has copy, drop {
        market: address,
        name: vector<u8>,
        treasury: address,
        owner: address,
        created_at: u64,
    }

    struct DepositEvent has copy, drop {
        market: address,
        depositor: address,
        recipient: address,
        deposit_amount: u64,
        payout_amount: u64,
        bill_id: u64,
        price: u64,
    }

    struct ClaimEvent has copy, drop {
        market: address,
        bill_id: u64,
        claimer: address,
        amount: u64,
        remaining: u64,
    }

    struct EmergencyPauseEvent has copy, drop {
        market: address,
        pauser: address,
        paused: bool,
    }

    struct FeeRecipientsUpdateEvent has copy, drop {
        market: address,
        fee_in_principal_recipient: address,
        fee_in_payout_recipient: address,
        updater: address,
    }

    struct FeeUpdateEvent has copy, drop {
        market: address,
        fee_in_principal: u64,
        fee_in_payout: u64,
        updater: address,
    }

    struct BCVUpdateIntervalChangedEvent has copy, drop {
        market: address,
        new_interval: u64,
        updater: address,
    }

    struct BCVUpdateEvent has copy, drop {
        market: address,
        previous_bcv: u64,
        new_bcv: u64,
        updater: address,
    }

    struct TermsUpdateEvent has copy, drop {
        market: address,
        parameter: u8,
        value: u128,
        updater: address,
    }

    struct StuckTokenTransferEvent has copy, drop {
        market: address,
        recipient: address,
        amount: u64,
        timestamp: u64,
    }

    public fun approve_redeemer<T0, T1>(arg0: &mut BondMarket<T0, T1>, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<address, bool>>(&arg0.redeemer_approved, v0)) {
            0x2::table::add<address, 0x2::vec_map::VecMap<address, bool>>(&mut arg0.redeemer_approved, v0, 0x2::vec_map::empty<address, bool>());
        };
        let v1 = 0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<address, bool>>(&mut arg0.redeemer_approved, v0);
        if (0x2::vec_map::contains<address, bool>(v1, &arg1)) {
            *0x2::vec_map::get_mut<address, bool>(v1, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<address, bool>(v1, arg1, arg2);
        };
    }

    public fun bcv_adjustment_range<T0, T1>(arg0: &BondMarket<T0, T1>, arg1: &0x2::clock::Clock) : (u64, u64, u64, bool, u64) {
        let v0 = arg0.terms.control_variable;
        let v1 = 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::bond_math::percentage_of(v0, 100000);
        let v2 = if (v0 > v1 && v0 - v1 > 1) {
            v0 - v1
        } else {
            1
        };
        let v3 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v4 = arg0.last_bcv_update_timestamp + arg0.min_bcv_update_interval;
        let v5 = v3 >= v4;
        let v6 = if (v5) {
            0
        } else {
            v4 - v3
        };
        (v0, v2, v0 + v0 * 3, v5, v6)
    }

    public fun bill_info<T0, T1>(arg0: &BondMarket<T0, T1>, arg1: u64) : (u64, u64, u64, u64, u64, u64) {
        assert!(0x2::table::contains<u64, Bill>(&arg0.bills, arg1), 12);
        let v0 = 0x2::table::borrow<u64, Bill>(&arg0.bills, arg1);
        (v0.payout, v0.payout_claimed, v0.vesting_term, v0.vesting_start_timestamp, v0.last_claim_timestamp, v0.true_price_paid)
    }

    fun calculate_current_debt<T0, T1>(arg0: &BondMarket<T0, T1>) : u64 {
        (arg0.total_debt as u64)
    }

    fun calculate_debt_decay<T0, T1>(arg0: &BondMarket<T0, T1>, arg1: u64) : u128 {
        if (arg1 <= arg0.last_decay) {
            return 0
        };
        0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::bond_math::calculate_decay(arg0.total_debt, arg1 - arg0.last_decay, arg0.terms.vesting_term)
    }

    fun calculate_payout_with_fees<T0, T1>(arg0: &BondMarket<T0, T1>, arg1: u64) : (u64, u64, u64) {
        let v0 = 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::bond_math::calculate_fee(arg1, arg0.fee_in_principal);
        let v1 = if (arg1 > v0) {
            arg1 - v0
        } else {
            0
        };
        let v2 = 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::bond_math::calculate_payout(value_of_token(arg0.principal_decimals, arg0.payout_decimals, v1), calculate_price<T0, T1>(arg0), pow10(arg0.payout_decimals));
        let v3 = 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::bond_math::calculate_fee(v2, arg0.fee_in_payout);
        let v4 = if (v2 > v3) {
            v2 - v3
        } else {
            0
        };
        (v4, v0, v3)
    }

    fun calculate_price<T0, T1>(arg0: &BondMarket<T0, T1>) : u64 {
        let v0 = 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::bond_math::calculate_bond_price(arg0.terms.control_variable, 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::bond_math::calculate_debt_ratio(value_of_token(arg0.principal_decimals, arg0.payout_decimals, calculate_current_debt<T0, T1>(arg0)), arg0.payout_token_initial_supply, pow10(arg0.payout_decimals)), pow10(arg0.principal_decimals));
        if (v0 < arg0.terms.minimum_price) {
            arg0.terms.minimum_price
        } else {
            v0
        }
    }

    fun calculate_true_price<T0, T1>(arg0: &BondMarket<T0, T1>) : u64 {
        (((calculate_price<T0, T1>(arg0) as u128) * (1000000 as u128) / ((1000000 - arg0.fee_in_principal) as u128)) as u64)
    }

    public fun claim<T0, T1>(arg0: &mut BondMarket<T0, T1>, arg1: &0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::bond_nft::BondNFT, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.paused && !arg0.emergency_paused, 23);
        let v0 = 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::bond_nft::bill_id(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(0x2::table::contains<u64, Bill>(&arg0.bills, v0), 12);
        let v2 = 0x2::table::borrow<u64, Bill>(&arg0.bills, v0);
        let v3 = 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::curve::calculate_vested(&arg0.vesting_config, v2.payout, v2.vesting_start_timestamp, v2.vesting_term, v1) - v2.payout_claimed;
        assert!(v3 > 0, 14);
        let v4 = v2.payout_claimed + v3;
        let v5 = 0x2::table::borrow_mut<u64, Bill>(&mut arg0.bills, v0);
        v5.payout_claimed = v4;
        v5.last_claim_timestamp = v1;
        let v6 = ClaimEvent{
            market    : 0x2::object::id_address<BondMarket<T0, T1>>(arg0),
            bill_id   : v0,
            claimer   : 0x2::tx_context::sender(arg3),
            amount    : v3,
            remaining : v2.payout - v4,
        };
        0x2::event::emit<ClaimEvent>(v6);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payout_balance, v3), arg3)
    }

    public fun create_market<T0, T1>(arg0: vector<u8>, arg1: &mut 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::treasury::Treasury<T0>, arg2: address, arg3: address, arg4: address, arg5: vector<address>, arg6: BondTerms, arg7: u64, arg8: u64, arg9: 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::curve::VestingConfig, arg10: u8, arg11: u8, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : address {
        assert!(arg2 != @0x0, 1);
        assert!(arg3 != @0x0, 1);
        assert!(arg7 < 1000000, 3);
        assert!(arg8 < 1000000, 3);
        assert!(arg6.vesting_term >= 129600, 5);
        assert!(arg6.control_variable > 0, 6);
        assert!(arg12 > 0, 26);
        let v0 = 0x2::clock::timestamp_ms(arg13) / 1000;
        let v1 = 0x2::vec_map::empty<address, bool>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg5)) {
            0x2::vec_map::insert<address, bool>(&mut v1, *0x1::vector::borrow<address>(&arg5, v2), true);
            v2 = v2 + 1;
        };
        let v3 = 0x2::object::id_address<0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::treasury::Treasury<T0>>(arg1);
        let v4 = BondMarket<T0, T1>{
            id                          : 0x2::object::new(arg14),
            payout_balance              : 0x2::balance::zero<T0>(),
            payout_decimals             : arg10,
            principal_decimals          : arg11,
            treasury_id                 : v3,
            fee_in_principal_recipient  : arg2,
            fee_in_payout_recipient     : arg3,
            terms                       : arg6,
            fee_in_principal            : arg7,
            fee_in_payout               : arg8,
            total_principal_billed      : 0,
            total_payout_given          : 0,
            payout_token_initial_supply : arg12,
            total_debt                  : arg6.initial_debt,
            last_decay                  : v0,
            last_bcv_update_timestamp   : v0,
            min_bcv_update_interval     : 10800,
            owner                       : arg4,
            operators                   : v1,
            paused                      : false,
            emergency_paused            : false,
            bills                       : 0x2::table::new<u64, Bill>(arg14),
            redeemer_approved           : 0x2::table::new<address, 0x2::vec_map::VecMap<address, bool>>(arg14),
            name                        : arg0,
            vesting_config              : arg9,
        };
        let v5 = 0x2::object::id_address<BondMarket<T0, T1>>(&v4);
        0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::treasury::whitelist_bond_contract<T0>(arg1, v5, true, arg6.max_payout, arg14);
        let v6 = MarketCreateEvent{
            market     : v5,
            name       : arg0,
            treasury   : v3,
            owner      : arg4,
            created_at : v0,
        };
        0x2::event::emit<MarketCreateEvent>(v6);
        0x2::transfer::share_object<BondMarket<T0, T1>>(v4);
        v5
    }

    public fun create_terms(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128) : BondTerms {
        BondTerms{
            control_variable : arg0,
            vesting_term     : arg1,
            minimum_price    : arg2,
            max_payout       : arg3,
            max_debt         : arg4,
            max_total_payout : arg5,
            initial_debt     : arg6,
        }
    }

    fun decay_debt<T0, T1>(arg0: &mut BondMarket<T0, T1>, arg1: u64) {
        arg0.total_debt = arg0.total_debt - calculate_debt_decay<T0, T1>(arg0, arg1);
        arg0.last_decay = arg1;
    }

    public fun deposit<T0, T1>(arg0: &mut BondMarket<T0, T1>, arg1: &mut 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::treasury::Treasury<T0>, arg2: &mut 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::bond_nft::BondNFTRegistry, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!arg0.paused && !arg0.emergency_paused, 23);
        assert!(arg5 != @0x0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let v1 = 0x2::object::id_address<BondMarket<T0, T1>>(arg0);
        decay_debt<T0, T1>(arg0, v0);
        let v2 = calculate_true_price<T0, T1>(arg0);
        assert!(arg4 >= v2, 7);
        let v3 = 0x2::coin::value<T1>(&arg3);
        let (v4, v5, v6) = calculate_payout_with_fees<T0, T1>(arg0, v3);
        let v7 = v3 - v5;
        arg0.total_debt = arg0.total_debt + (v3 as u128);
        assert!(arg0.total_debt <= arg0.terms.max_debt, 8);
        assert!(v4 >= pow10(arg0.payout_decimals) / 10000, 9);
        assert!(v4 <= arg0.terms.max_payout, 10);
        let v8 = arg0.total_payout_given + (v4 as u128);
        assert!(v8 <= arg0.terms.max_total_payout, 11);
        arg0.total_payout_given = v8;
        arg0.total_principal_billed = arg0.total_principal_billed + (v7 as u128);
        let v9 = 0x2::coin::into_balance<T1>(arg3);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v9, v5), arg7), arg0.fee_in_principal_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v9, arg7), 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::treasury::get_payout_address<T0>(arg1));
        let (v10, v11) = 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::treasury::deposit_with_fee<T0>(arg1, v1, v7, v4, v6, arg6, arg7);
        let v12 = v11;
        let v13 = v10;
        if (0x2::coin::value<T0>(&v12) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v12, arg0.fee_in_payout_recipient);
        } else {
            0x2::coin::destroy_zero<T0>(v12);
        };
        let v14 = 0x2::coin::value<T0>(&v13);
        0x2::balance::join<T0>(&mut arg0.payout_balance, 0x2::coin::into_balance<T0>(v13));
        let v15 = 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::bond_nft::mint(arg2, arg5, v1, arg7);
        let v16 = Bill{
            payout                  : v14,
            payout_claimed          : 0,
            vesting_term            : arg0.terms.vesting_term,
            vesting_start_timestamp : v0,
            last_claim_timestamp    : v0,
            true_price_paid         : v2,
        };
        0x2::table::add<u64, Bill>(&mut arg0.bills, v15, v16);
        let v17 = DepositEvent{
            market         : v1,
            depositor      : 0x2::tx_context::sender(arg7),
            recipient      : arg5,
            deposit_amount : v3,
            payout_amount  : v14,
            bill_id        : v15,
            price          : v2,
        };
        0x2::event::emit<DepositEvent>(v17);
        v15
    }

    public fun emergency_pause<T0, T1>(arg0: &mut BondMarket<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner || 0x2::vec_map::contains<address, bool>(&arg0.operators, &v0), 25);
        arg0.emergency_paused = arg1;
        let v1 = EmergencyPauseEvent{
            market : 0x2::object::id_address<BondMarket<T0, T1>>(arg0),
            pauser : v0,
            paused : arg1,
        };
        0x2::event::emit<EmergencyPauseEvent>(v1);
    }

    public fun get_fee_in_payout<T0, T1>(arg0: &BondMarket<T0, T1>) : u64 {
        arg0.fee_in_payout
    }

    public fun get_fee_in_payout_recipient<T0, T1>(arg0: &BondMarket<T0, T1>) : address {
        arg0.fee_in_payout_recipient
    }

    public fun get_fee_in_principal<T0, T1>(arg0: &BondMarket<T0, T1>) : u64 {
        arg0.fee_in_principal
    }

    public fun get_fee_in_principal_recipient<T0, T1>(arg0: &BondMarket<T0, T1>) : address {
        arg0.fee_in_principal_recipient
    }

    public fun get_name<T0, T1>(arg0: &BondMarket<T0, T1>) : vector<u8> {
        arg0.name
    }

    public fun get_owner<T0, T1>(arg0: &BondMarket<T0, T1>) : address {
        arg0.owner
    }

    public fun get_payout_balance<T0, T1>(arg0: &BondMarket<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.payout_balance)
    }

    public fun get_payout_decimals<T0, T1>(arg0: &BondMarket<T0, T1>) : u8 {
        arg0.payout_decimals
    }

    public fun get_price<T0, T1>(arg0: &BondMarket<T0, T1>) : u64 {
        calculate_true_price<T0, T1>(arg0)
    }

    public fun get_principal_decimals<T0, T1>(arg0: &BondMarket<T0, T1>) : u8 {
        arg0.principal_decimals
    }

    public fun get_terms<T0, T1>(arg0: &BondMarket<T0, T1>) : (u64, u64, u64, u64, u128, u128, u128) {
        (arg0.terms.control_variable, arg0.terms.vesting_term, arg0.terms.minimum_price, arg0.terms.max_payout, arg0.terms.max_debt, arg0.terms.max_total_payout, arg0.terms.initial_debt)
    }

    public fun get_total_payout_given<T0, T1>(arg0: &BondMarket<T0, T1>) : u128 {
        arg0.total_payout_given
    }

    public fun get_total_principal_billed<T0, T1>(arg0: &BondMarket<T0, T1>) : u128 {
        arg0.total_principal_billed
    }

    public fun get_treasury_id<T0, T1>(arg0: &BondMarket<T0, T1>) : address {
        arg0.treasury_id
    }

    public fun get_vesting_config<T0, T1>(arg0: &BondMarket<T0, T1>) : (u8, u64) {
        0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::curve::vesting_config_info(&arg0.vesting_config)
    }

    public fun is_paused<T0, T1>(arg0: &BondMarket<T0, T1>) : bool {
        arg0.paused || arg0.emergency_paused
    }

    fun is_redeemer_approved<T0, T1>(arg0: &BondMarket<T0, T1>, arg1: address, arg2: address) : bool {
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<address, bool>>(&arg0.redeemer_approved, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, 0x2::vec_map::VecMap<address, bool>>(&arg0.redeemer_approved, arg1);
        0x2::vec_map::contains<address, bool>(v0, &arg2) && *0x2::vec_map::get<address, bool>(v0, &arg2)
    }

    public fun market_info<T0, T1>(arg0: &BondMarket<T0, T1>) : (vector<u8>, address, bool, bool, u128, u128, u64, address, u64, u64, address, address, u64, u64, u64, u64, u64, u128, u128, u8, u64) {
        let (v0, v1) = 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::curve::vesting_config_info(&arg0.vesting_config);
        (arg0.name, arg0.owner, arg0.paused, arg0.emergency_paused, arg0.total_principal_billed, arg0.total_payout_given, (arg0.total_debt as u64), arg0.treasury_id, arg0.fee_in_principal, arg0.fee_in_payout, arg0.fee_in_principal_recipient, arg0.fee_in_payout_recipient, calculate_true_price<T0, T1>(arg0), arg0.terms.control_variable, arg0.terms.vesting_term, arg0.terms.minimum_price, arg0.terms.max_payout, arg0.terms.max_debt, arg0.terms.max_total_payout, v0, v1)
    }

    fun pow10(arg0: u8) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun set_bcv<T0, T1>(arg0: &mut BondMarket<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner || 0x2::vec_map::contains<address, bool>(&arg0.operators, &v0), 25);
        assert!(arg1 > 0, 19);
        let v1 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(arg0.last_bcv_update_timestamp + arg0.min_bcv_update_interval <= v1, 20);
        let v2 = arg0.terms.control_variable;
        if (arg1 > v2) {
            assert!(arg1 <= v2 + v2 * 3, 21);
        } else {
            let v3 = 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::bond_math::percentage_of(v2, 100000);
            let v4 = if (v2 > v3) {
                v2 - v3
            } else {
                0
            };
            assert!(arg1 >= v4, 22);
        };
        arg0.terms.control_variable = arg1;
        arg0.last_bcv_update_timestamp = v1;
        let v5 = BCVUpdateEvent{
            market       : 0x2::object::id_address<BondMarket<T0, T1>>(arg0),
            previous_bcv : v2,
            new_bcv      : arg1,
            updater      : v0,
        };
        0x2::event::emit<BCVUpdateEvent>(v5);
    }

    public fun set_bcv_update_interval<T0, T1>(arg0: &mut BondMarket<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner || 0x2::vec_map::contains<address, bool>(&arg0.operators, &v0), 25);
        assert!(arg1 >= 540, 26);
        arg0.min_bcv_update_interval = arg1;
        let v1 = BCVUpdateIntervalChangedEvent{
            market       : 0x2::object::id_address<BondMarket<T0, T1>>(arg0),
            new_interval : arg1,
            updater      : v0,
        };
        0x2::event::emit<BCVUpdateIntervalChangedEvent>(v1);
    }

    public fun set_bond_terms<T0, T1>(arg0: &mut BondMarket<T0, T1>, arg1: u8, arg2: u128, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner || 0x2::vec_map::contains<address, bool>(&arg0.operators, &v0), 25);
        if (arg1 == 0) {
            let v1 = (arg2 as u64);
            assert!(v1 >= 129600, 5);
            arg0.terms.vesting_term = v1;
        } else if (arg1 == 1) {
            arg0.terms.max_payout = (arg2 as u64);
        } else if (arg1 == 2) {
            arg0.terms.max_debt = arg2;
        } else if (arg1 == 3) {
            arg0.terms.minimum_price = (arg2 as u64);
        } else {
            assert!(arg1 == 4, 26);
            arg0.terms.max_total_payout = arg2;
        };
        let v2 = TermsUpdateEvent{
            market    : 0x2::object::id_address<BondMarket<T0, T1>>(arg0),
            parameter : arg1,
            value     : arg2,
            updater   : v0,
        };
        0x2::event::emit<TermsUpdateEvent>(v2);
    }

    public fun set_fee<T0, T1>(arg0: &mut BondMarket<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner || 0x2::vec_map::contains<address, bool>(&arg0.operators, &v0), 25);
        assert!(arg1 < 1000000, 3);
        assert!(arg2 < 1000000, 3);
        arg0.fee_in_principal = arg1;
        arg0.fee_in_payout = arg2;
        let v1 = FeeUpdateEvent{
            market           : 0x2::object::id_address<BondMarket<T0, T1>>(arg0),
            fee_in_principal : arg1,
            fee_in_payout    : arg2,
            updater          : v0,
        };
        0x2::event::emit<FeeUpdateEvent>(v1);
    }

    public fun set_fee_recipients<T0, T1>(arg0: &mut BondMarket<T0, T1>, arg1: address, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner || 0x2::vec_map::contains<address, bool>(&arg0.operators, &v0), 25);
        assert!(arg1 != @0x0, 1);
        assert!(arg2 != @0x0, 1);
        arg0.fee_in_principal_recipient = arg1;
        arg0.fee_in_payout_recipient = arg2;
        let v1 = FeeRecipientsUpdateEvent{
            market                     : 0x2::object::id_address<BondMarket<T0, T1>>(arg0),
            fee_in_principal_recipient : arg1,
            fee_in_payout_recipient    : arg2,
            updater                    : v0,
        };
        0x2::event::emit<FeeRecipientsUpdateEvent>(v1);
    }

    public fun transfer_ownership<T0, T1>(arg0: &mut BondMarket<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 24);
        assert!(arg1 != @0x0, 1);
        arg0.owner = arg1;
    }

    public fun transfer_stuck_token<T0, T1>(arg0: &mut BondMarket<T0, T1>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 24);
        assert!(arg2 != @0x0, 1);
        let v0 = 0x2::balance::value<T0>(&arg0.payout_balance);
        let v1 = if (arg1 == 0 || arg1 > v0) {
            v0
        } else {
            arg1
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payout_balance, v1), arg4), arg2);
        };
        let v2 = StuckTokenTransferEvent{
            market    : 0x2::object::id_address<BondMarket<T0, T1>>(arg0),
            recipient : arg2,
            amount    : v1,
            timestamp : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<StuckTokenTransferEvent>(v2);
    }

    fun value_of_token(arg0: u8, arg1: u8, arg2: u64) : u64 {
        if (arg1 >= arg0) {
            arg2 * pow10(arg1 - arg0)
        } else {
            arg2 / pow10(arg0 - arg1)
        }
    }

    // decompiled from Move bytecode v7
}

