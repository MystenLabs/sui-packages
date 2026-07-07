module 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_market {
    struct Market<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        oracle: 0x2::object::ID,
        irm: 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::irm::InterestRateModel,
        lltv: u256,
        fee: u256,
        fee_shares: u128,
        last_update: u64,
        flash_active: bool,
        total_supply_assets: u128,
        total_borrow_assets: u128,
        total_borrow_shares: u128,
        total_collateral_assets: u128,
        total_collateral_shares: u128,
        loan: 0x2::balance::Balance<T1>,
        collateral: 0x2::balance::Balance<T0>,
        treasury: 0x2::coin::TreasuryCap<T2>,
        accounts: 0x2::table::Table<0x2::object::ID, Account>,
        liquidators: 0x2::vec_set::VecSet<address>,
    }

    struct Account has store {
        borrow_shares: u128,
        collateral_shares: u128,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        market: 0x2::object::ID,
    }

    struct LiquidationReceipt {
        market: 0x2::object::ID,
        repaid_assets: u128,
    }

    struct FlashLoan {
        market: 0x2::object::ID,
        loan_amount: u64,
        loan_fee: u64,
        collateral_amount: u64,
        collateral_fee: u64,
    }

    public fun borrow<T0, T1, T2>(arg0: &mut Market<T0, T1, T2>, arg1: &Position, arg2: u64, arg3: 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::Price, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_unlocked<T0, T1, T2>(arg0);
        assert!(arg2 != 0, 20);
        assert!(arg2 <= 0x2::balance::value<T1>(&arg0.loan), 21);
        assert_position<T0, T1, T2>(arg0, arg1);
        accrue<T0, T1, T2>(arg0, arg4);
        let (v0, v1) = checked_price<T0, T1, T2>(arg0, arg3);
        let v2 = to_shares_up((arg2 as u128), arg0.total_borrow_assets, arg0.total_borrow_shares);
        arg0.total_borrow_assets = arg0.total_borrow_assets + (arg2 as u128);
        arg0.total_borrow_shares = arg0.total_borrow_shares + v2;
        let v3 = 0x2::object::id<Position>(arg1);
        let v4 = 0x2::table::borrow_mut<0x2::object::ID, Account>(&mut arg0.accounts, v3);
        v4.borrow_shares = v4.borrow_shares + v2;
        assert_healthy(v4.borrow_shares, to_assets_down(v4.collateral_shares, arg0.total_collateral_assets, arg0.total_collateral_shares), v0, arg0.lltv, arg0.total_borrow_assets, arg0.total_borrow_shares);
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::borrowed(0x2::object::id<Market<T0, T1, T2>>(arg0), v3, (arg2 as u128), v2, v1, account_state<T0, T1, T2>(arg0, v3), event_state<T0, T1, T2>(arg0));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.loan, arg2), arg5)
    }

    public fun share<T0, T1, T2>(arg0: Market<T0, T1, T2>) {
        0x2::transfer::share_object<Market<T0, T1, T2>>(arg0);
    }

    public fun new<T0, T1, T2>(arg0: 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::PriceMode, arg1: u64, arg2: u256, arg3: 0x2::coin::TreasuryCap<T2>, arg4: 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::irm::InterestRateModel, arg5: u256, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (Market<T0, T1, T2>, 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::Oracle, 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_market_authority::MarketCap) {
        assert!(0x2::coin::total_supply<T2>(&arg3) == 0, 34);
        assert!(arg5 != 0 && arg5 < 1000000000000000000, 19);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x1::type_name::with_defining_ids<T2>();
        let v3 = if (v0 != v1) {
            if (v2 != v1) {
                v2 != v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 32);
        let v4 = 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::new(arg0, arg1, arg2, arg7);
        let v5 = 0x2::object::id<0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::Oracle>(&v4);
        let v6 = Market<T0, T1, T2>{
            id                      : 0x2::object::new(arg7),
            oracle                  : v5,
            irm                     : arg4,
            lltv                    : arg5,
            fee                     : 0,
            fee_shares              : 0,
            last_update             : 0x2::clock::timestamp_ms(arg6),
            flash_active            : false,
            total_supply_assets     : 0,
            total_borrow_assets     : 0,
            total_borrow_shares     : 0,
            total_collateral_assets : 0,
            total_collateral_shares : 0,
            loan                    : 0x2::balance::zero<T1>(),
            collateral              : 0x2::balance::zero<T0>(),
            treasury                : arg3,
            accounts                : 0x2::table::new<0x2::object::ID, Account>(arg7),
            liquidators             : 0x2::vec_set::empty<address>(),
        };
        let v7 = 0x2::object::id<Market<T0, T1, T2>>(&v6);
        let v8 = 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_market_authority::new(v7, v5, arg7);
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::market_created(v7, 0x2::object::id<0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_market_authority::MarketCap>(&v8), v5, v0, v1, v2, arg5, v6.fee, v6.last_update, v6.irm, event_state<T0, T1, T2>(&v6));
        (v6, v4, v8)
    }

    fun account_state<T0, T1, T2>(arg0: &Market<T0, T1, T2>, arg1: 0x2::object::ID) : 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::AccountState {
        let v0 = 0x2::table::borrow<0x2::object::ID, Account>(&arg0.accounts, arg1);
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::account_state(v0.borrow_shares, to_assets_up(v0.borrow_shares, arg0.total_borrow_assets, arg0.total_borrow_shares), v0.collateral_shares, to_assets_down(v0.collateral_shares, arg0.total_collateral_assets, arg0.total_collateral_shares))
    }

    fun accrue<T0, T1, T2>(arg0: &mut Market<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        let v0 = (0x2::clock::timestamp_ms(arg1) - arg0.last_update) / 1000;
        if (v0 == 0) {
            return
        };
        arg0.last_update = arg0.last_update + v0 * 1000;
        if (arg0.total_supply_assets == 0) {
            0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::interest_accrued(0x2::object::id<Market<T0, T1, T2>>(arg0), 0, 0, 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::irm::rate_at_target(&arg0.irm), arg0.last_update, event_state<T0, T1, T2>(arg0));
            return
        };
        let v1 = (0x1::u256::div_ceil((arg0.total_borrow_assets as u256) * 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::irm::interest_factor_mut(&mut arg0.irm, 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::irm::utilization((arg0.total_borrow_assets as u256), (arg0.total_supply_assets as u256)), v0), 1000000000000000000) as u128);
        let v2 = 0;
        if (v1 != 0) {
            arg0.total_borrow_assets = arg0.total_borrow_assets + v1;
            arg0.total_supply_assets = arg0.total_supply_assets + v1;
            if (arg0.fee != 0) {
                let v3 = (0x1::u256::div_ceil((v1 as u256) * arg0.fee, 1000000000000000000) as u128);
                let v4 = to_supply_shares(v3, arg0.total_supply_assets - v3, supply_shares<T0, T1, T2>(arg0));
                v2 = v4;
                arg0.fee_shares = arg0.fee_shares + v4;
            };
        };
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::interest_accrued(0x2::object::id<Market<T0, T1, T2>>(arg0), v1, v2, 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::irm::rate_at_target(&arg0.irm), arg0.last_update, event_state<T0, T1, T2>(arg0));
    }

    public fun add_liquidator<T0, T1, T2>(arg0: &mut Market<T0, T1, T2>, arg1: &0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_market_authority::MarketCap, arg2: address) {
        assert_unlocked<T0, T1, T2>(arg0);
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_market_authority::assert_market(arg1, 0x2::object::id<Market<T0, T1, T2>>(arg0));
        0x2::vec_set::insert<address>(&mut arg0.liquidators, arg2);
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::liquidator_updated(0x2::object::id<Market<T0, T1, T2>>(arg0), arg2, true, 0x2::vec_set::into_keys<address>(arg0.liquidators));
    }

    fun assert_healthy(arg0: u128, arg1: u128, arg2: u256, arg3: u256, arg4: u128, arg5: u128) {
        let v0 = (to_assets_up(arg0, arg4, arg5) as u256);
        if (v0 == 0) {
            return
        };
        assert!((arg1 as u256) * arg2 / 1000000000000000000 * arg3 / 1000000000000000000 >= v0, 22);
    }

    fun assert_position<T0, T1, T2>(arg0: &Market<T0, T1, T2>, arg1: &Position) {
        assert!(arg1.market == 0x2::object::id<Market<T0, T1, T2>>(arg0), 25);
        assert!(0x2::table::contains<0x2::object::ID, Account>(&arg0.accounts, 0x2::object::id<Position>(arg1)), 25);
    }

    fun assert_unlocked<T0, T1, T2>(arg0: &Market<T0, T1, T2>) {
        assert!(!arg0.flash_active, 33);
    }

    fun checked_price<T0, T1, T2>(arg0: &Market<T0, T1, T2>, arg1: 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::Price) : (u256, 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::PriceSnapshot) {
        let (v0, v1, v2, v3) = 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::destroy_price(arg1);
        assert!(v0 == arg0.oracle, 23);
        (v1, 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::price_snapshot(v0, v1, v2, v3))
    }

    public fun close_position<T0, T1, T2>(arg0: &mut Market<T0, T1, T2>, arg1: Position) {
        assert_unlocked<T0, T1, T2>(arg0);
        let v0 = 0x2::object::id<Market<T0, T1, T2>>(arg0);
        assert!(arg1.market == v0, 25);
        let v1 = 0x2::object::id<Position>(&arg1);
        assert!(0x2::table::contains<0x2::object::ID, Account>(&arg0.accounts, v1), 25);
        let v2 = 0x2::table::borrow<0x2::object::ID, Account>(&arg0.accounts, v1);
        assert!(v2.borrow_shares == 0 && v2.collateral_shares == 0, 26);
        let Account {
            borrow_shares     : _,
            collateral_shares : _,
        } = 0x2::table::remove<0x2::object::ID, Account>(&mut arg0.accounts, v1);
        let Position {
            id     : v5,
            market : _,
        } = arg1;
        0x2::object::delete(v5);
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::position_closed(v0, v1, zero_account_state());
    }

    public fun collateral_balance<T0, T1, T2>(arg0: &Market<T0, T1, T2>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    fun event_state<T0, T1, T2>(arg0: &Market<T0, T1, T2>) : 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::MarketState {
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::market_state(arg0.total_supply_assets, supply_shares<T0, T1, T2>(arg0), arg0.fee_shares, arg0.total_borrow_assets, arg0.total_borrow_shares, arg0.total_collateral_assets, arg0.total_collateral_shares, arg0.last_update, 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::irm::rate_at_target(&arg0.irm), arg0.fee, arg0.flash_active)
    }

    public fun flash_collateral_amount(arg0: &FlashLoan) : u64 {
        arg0.collateral_amount
    }

    public fun flash_collateral_fee(arg0: &FlashLoan) : u64 {
        arg0.collateral_fee
    }

    fun flash_fee_for(arg0: u64) : u64 {
        (0x1::u256::div_ceil((arg0 as u256) * 900000000000000, 1000000000000000000) as u64)
    }

    public fun flash_loan<T0, T1, T2>(arg0: &mut Market<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>, FlashLoan) {
        assert_unlocked<T0, T1, T2>(arg0);
        assert!(arg1 != 0 || arg2 != 0, 20);
        assert!(arg1 <= 0x2::balance::value<T1>(&arg0.loan), 21);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg0.collateral), 21);
        arg0.flash_active = true;
        let v0 = flash_fee_for(arg1);
        let v1 = flash_fee_for(arg2);
        let v2 = 0x2::object::id<Market<T0, T1, T2>>(arg0);
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::flash_loaned(v2, (arg1 as u128), (v0 as u128), (arg2 as u128), (v1 as u128), event_state<T0, T1, T2>(arg0));
        let v3 = FlashLoan{
            market            : v2,
            loan_amount       : arg1,
            loan_fee          : v0,
            collateral_amount : arg2,
            collateral_fee    : v1,
        };
        (0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.loan, arg1), arg3), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.collateral, arg2), arg3), v3)
    }

    public fun flash_loan_amount(arg0: &FlashLoan) : u64 {
        arg0.loan_amount
    }

    public fun flash_loan_fee(arg0: &FlashLoan) : u64 {
        arg0.loan_fee
    }

    public fun init_display(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display_registry::DisplayCap<Position> {
        let (v0, v1) = 0x2::display_registry::new_with_publisher<Position>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        0x2::display_registry::set<Position>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"su Lending Position"));
        0x2::display_registry::set<Position>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A lending position in su market {market}."));
        0x2::display_registry::set<Position>(&mut v3, &v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://su.fi/position/{id}.svg"));
        0x2::display_registry::set<Position>(&mut v3, &v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://su.fi"));
        0x2::display_registry::share<Position>(v3);
        v2
    }

    fun is_liquidatable(arg0: u128, arg1: u128, arg2: u256, arg3: u256) : bool {
        if (arg1 == 0) {
            return false
        };
        (arg0 as u256) * arg2 / 1000000000000000000 * arg3 / 1000000000000000000 < (arg1 as u256)
    }

    public fun liquidate<T0, T1, T2>(arg0: &mut Market<T0, T1, T2>, arg1: 0x2::object::ID, arg2: u64, arg3: 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::Price, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, LiquidationReceipt) {
        assert_unlocked<T0, T1, T2>(arg0);
        assert!(arg2 != 0, 20);
        assert!(0x2::table::contains<0x2::object::ID, Account>(&arg0.accounts, arg1), 25);
        if (!0x2::vec_set::is_empty<address>(&arg0.liquidators)) {
            let v0 = 0x2::tx_context::sender(arg5);
            assert!(0x2::vec_set::contains<address>(&arg0.liquidators, &v0), 30);
        };
        accrue<T0, T1, T2>(arg0, arg4);
        let (v1, v2) = checked_price<T0, T1, T2>(arg0, arg3);
        let v3 = 0x2::object::id<Market<T0, T1, T2>>(arg0);
        let v4 = 0x2::table::borrow<0x2::object::ID, Account>(&arg0.accounts, arg1);
        let v5 = v4.borrow_shares;
        let v6 = v4.collateral_shares;
        let v7 = to_assets_up(v5, arg0.total_borrow_assets, arg0.total_borrow_shares);
        let v8 = to_assets_down(v6, arg0.total_collateral_assets, arg0.total_collateral_shares);
        assert!(is_liquidatable(v8, v7, v1, arg0.lltv), 28);
        let v9 = liquidation_incentive_factor(arg0.lltv);
        let v10 = if ((v8 as u256) * v1 / 1000000000000000000 < (v7 as u256)) {
            v7
        } else {
            (((v7 as u256) * 500000000000000000 / 1000000000000000000) as u128)
        };
        let v11 = 0x1::u128::min((arg2 as u128), v10);
        let v12 = v11;
        let v13 = (((v11 as u256) * v9 / v1) as u128);
        let v14 = v13;
        if (v13 > v8) {
            v14 = v8;
            v12 = (0x1::u256::div_ceil((v8 as u256) * v1, v9) as u128);
        };
        assert!(v12 != 0 && v14 != 0, 20);
        let v15 = if (v12 == v7) {
            v5
        } else {
            to_shares_down(v12, arg0.total_borrow_assets, arg0.total_borrow_shares)
        };
        let v16 = if (v14 == v8) {
            v6
        } else {
            to_shares_up(v14, arg0.total_collateral_assets, arg0.total_collateral_shares)
        };
        let v17 = arg0.total_borrow_assets - v12;
        let v18 = v17;
        let v19 = arg0.total_borrow_shares - v15;
        let v20 = v19;
        let v21 = v5 - v15;
        let v22 = v21;
        let v23 = v6 - v16;
        let v24 = 0;
        if (v23 == 0 && v21 != 0) {
            let v25 = to_assets_up(v21, v17, v19);
            v24 = v25;
            v18 = v17 - v25;
            v20 = v19 - v21;
            v22 = 0;
        };
        arg0.total_borrow_assets = v18;
        arg0.total_borrow_shares = v20;
        arg0.total_supply_assets = arg0.total_supply_assets - v24;
        arg0.total_collateral_assets = arg0.total_collateral_assets - v14;
        arg0.total_collateral_shares = arg0.total_collateral_shares - v16;
        let v26 = 0x2::table::borrow_mut<0x2::object::ID, Account>(&mut arg0.accounts, arg1);
        v26.borrow_shares = v22;
        v26.collateral_shares = v23;
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::liquidated(v3, arg1, v12, v15, v14, v16, v24, v2, account_state<T0, T1, T2>(arg0, arg1), event_state<T0, T1, T2>(arg0));
        let v27 = LiquidationReceipt{
            market        : v3,
            repaid_assets : v12,
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.collateral, (v14 as u64)), arg5), v27)
    }

    fun liquidation_incentive_factor(arg0: u256) : u256 {
        let v0 = 1000000000000000000;
        0x1::u256::min(v0 * v0 / (v0 - 300000000000000000 * (v0 - arg0) / v0), 1150000000000000000)
    }

    public fun loan_balance<T0, T1, T2>(arg0: &Market<T0, T1, T2>) : u64 {
        0x2::balance::value<T1>(&arg0.loan)
    }

    fun mul_div_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    fun mul_div_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (0x1::u256::div_ceil((arg0 as u256) * (arg1 as u256), (arg2 as u256)) as u128)
    }

    public fun open_position<T0, T1, T2>(arg0: &mut Market<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : Position {
        assert_unlocked<T0, T1, T2>(arg0);
        let v0 = 0x2::object::id<Market<T0, T1, T2>>(arg0);
        let v1 = Position{
            id     : 0x2::object::new(arg1),
            market : v0,
        };
        let v2 = 0x2::object::id<Position>(&v1);
        let v3 = Account{
            borrow_shares     : 0,
            collateral_shares : 0,
        };
        0x2::table::add<0x2::object::ID, Account>(&mut arg0.accounts, v2, v3);
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::position_opened(v0, v2, zero_account_state());
        v1
    }

    public fun remove_liquidator<T0, T1, T2>(arg0: &mut Market<T0, T1, T2>, arg1: &0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_market_authority::MarketCap, arg2: address) {
        assert_unlocked<T0, T1, T2>(arg0);
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_market_authority::assert_market(arg1, 0x2::object::id<Market<T0, T1, T2>>(arg0));
        0x2::vec_set::remove<address>(&mut arg0.liquidators, &arg2);
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::liquidator_updated(0x2::object::id<Market<T0, T1, T2>>(arg0), arg2, false, 0x2::vec_set::into_keys<address>(arg0.liquidators));
    }

    public fun repay<T0, T1, T2>(arg0: &mut Market<T0, T1, T2>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_unlocked<T0, T1, T2>(arg0);
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 != 0, 20);
        assert!(0x2::table::contains<0x2::object::ID, Account>(&arg0.accounts, arg1), 25);
        accrue<T0, T1, T2>(arg0, arg3);
        let v1 = 0x2::table::borrow<0x2::object::ID, Account>(&arg0.accounts, arg1).borrow_shares;
        let v2 = to_assets_up(v1, arg0.total_borrow_assets, arg0.total_borrow_shares);
        assert!(v2 != 0, 24);
        let v3 = 0x1::u128::min((v0 as u128), v2);
        let v4 = if (v3 == v2) {
            v1
        } else {
            to_shares_down(v3, arg0.total_borrow_assets, arg0.total_borrow_shares)
        };
        arg0.total_borrow_assets = arg0.total_borrow_assets - v3;
        arg0.total_borrow_shares = arg0.total_borrow_shares - v4;
        0x2::table::borrow_mut<0x2::object::ID, Account>(&mut arg0.accounts, arg1).borrow_shares = v1 - v4;
        0x2::balance::join<T1>(&mut arg0.loan, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, (v3 as u64), arg4)));
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::repaid(0x2::object::id<Market<T0, T1, T2>>(arg0), arg1, v3, v4, account_state<T0, T1, T2>(arg0, arg1), event_state<T0, T1, T2>(arg0));
        arg2
    }

    public fun repay_flash_loan<T0, T1, T2>(arg0: &mut Market<T0, T1, T2>, arg1: FlashLoan, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T0>) {
        let FlashLoan {
            market            : v0,
            loan_amount       : v1,
            loan_fee          : v2,
            collateral_amount : v3,
            collateral_fee    : v4,
        } = arg1;
        assert!(v0 == 0x2::object::id<Market<T0, T1, T2>>(arg0), 25);
        let v5 = 0x2::coin::value<T1>(&arg2);
        let v6 = 0x2::coin::value<T0>(&arg3);
        assert!((v5 as u128) >= (v1 as u128) + (v2 as u128), 29);
        assert!((v6 as u128) >= (v3 as u128) + (v4 as u128), 29);
        0x2::balance::join<T1>(&mut arg0.loan, 0x2::coin::into_balance<T1>(arg2));
        0x2::balance::join<T0>(&mut arg0.collateral, 0x2::coin::into_balance<T0>(arg3));
        arg0.total_supply_assets = arg0.total_supply_assets + ((v5 - v1) as u128);
        arg0.total_collateral_assets = arg0.total_collateral_assets + ((v6 - v3) as u128);
        arg0.flash_active = false;
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::flash_loan_repaid(v0, (v5 as u128), (v6 as u128), (v1 as u128), (v3 as u128), event_state<T0, T1, T2>(arg0));
    }

    public fun repay_liquidation<T0, T1, T2>(arg0: &mut Market<T0, T1, T2>, arg1: LiquidationReceipt, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_unlocked<T0, T1, T2>(arg0);
        let LiquidationReceipt {
            market        : v0,
            repaid_assets : v1,
        } = arg1;
        assert!(v0 == 0x2::object::id<Market<T0, T1, T2>>(arg0), 25);
        assert!((0x2::coin::value<T1>(&arg2) as u128) >= v1, 29);
        let v2 = (0x2::coin::value<T1>(&arg2) as u128) - v1;
        arg0.total_supply_assets = arg0.total_supply_assets + v2;
        0x2::balance::join<T1>(&mut arg0.loan, 0x2::coin::into_balance<T1>(arg2));
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::liquidation_repaid(v0, v1, v2, event_state<T0, T1, T2>(arg0));
    }

    public fun set_fee<T0, T1, T2>(arg0: &mut Market<T0, T1, T2>, arg1: &0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_acl::AdminWitness, arg2: u256, arg3: &0x2::clock::Clock) {
        assert_unlocked<T0, T1, T2>(arg0);
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_acl::assert_has_role(arg1, 1);
        assert!(arg2 <= 200000000000000000, 27);
        accrue<T0, T1, T2>(arg0, arg3);
        arg0.fee = arg2;
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::fee_set(0x2::object::id<Market<T0, T1, T2>>(arg0), arg2, event_state<T0, T1, T2>(arg0));
    }

    public fun set_irm<T0, T1, T2>(arg0: &mut Market<T0, T1, T2>, arg1: &0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_market_authority::MarketCap, arg2: 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::irm::InterestRateModel, arg3: &0x2::clock::Clock) {
        assert_unlocked<T0, T1, T2>(arg0);
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_market_authority::assert_market(arg1, 0x2::object::id<Market<T0, T1, T2>>(arg0));
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::irm::assert_kinked(&arg0.irm);
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::irm::assert_kinked(&arg2);
        accrue<T0, T1, T2>(arg0, arg3);
        arg0.irm = arg2;
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::interest_rate_model_set(0x2::object::id<Market<T0, T1, T2>>(arg0), arg0.irm, event_state<T0, T1, T2>(arg0));
    }

    public fun supply<T0, T1, T2>(arg0: &mut Market<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_unlocked<T0, T1, T2>(arg0);
        let v0 = (0x2::coin::value<T1>(&arg1) as u128);
        assert!(v0 != 0, 20);
        accrue<T0, T1, T2>(arg0, arg2);
        let v1 = to_supply_shares(v0, arg0.total_supply_assets, supply_shares<T0, T1, T2>(arg0));
        assert!(v1 != 0, 20);
        arg0.total_supply_assets = arg0.total_supply_assets + v0;
        0x2::balance::join<T1>(&mut arg0.loan, 0x2::coin::into_balance<T1>(arg1));
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::supplied(0x2::object::id<Market<T0, T1, T2>>(arg0), v0, v1, event_state<T0, T1, T2>(arg0));
        0x2::coin::mint<T2>(&mut arg0.treasury, (v1 as u64), arg3)
    }

    public fun supply_collateral<T0, T1, T2>(arg0: &mut Market<T0, T1, T2>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_unlocked<T0, T1, T2>(arg0);
        let v0 = (0x2::coin::value<T0>(&arg2) as u128);
        assert!(v0 != 0, 20);
        assert!(0x2::table::contains<0x2::object::ID, Account>(&arg0.accounts, arg1), 25);
        accrue<T0, T1, T2>(arg0, arg3);
        let v1 = to_shares_down(v0, arg0.total_collateral_assets, arg0.total_collateral_shares);
        assert!(v1 != 0, 20);
        arg0.total_collateral_assets = arg0.total_collateral_assets + v0;
        arg0.total_collateral_shares = arg0.total_collateral_shares + v1;
        0x2::balance::join<T0>(&mut arg0.collateral, 0x2::coin::into_balance<T0>(arg2));
        0x2::table::borrow_mut<0x2::object::ID, Account>(&mut arg0.accounts, arg1).collateral_shares = 0x2::table::borrow<0x2::object::ID, Account>(&arg0.accounts, arg1).collateral_shares + v1;
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::collateral_supplied(0x2::object::id<Market<T0, T1, T2>>(arg0), arg1, v0, v1, account_state<T0, T1, T2>(arg0, arg1), event_state<T0, T1, T2>(arg0));
    }

    fun supply_shares<T0, T1, T2>(arg0: &Market<T0, T1, T2>) : u128 {
        (0x2::coin::total_supply<T2>(&arg0.treasury) as u128) + arg0.fee_shares
    }

    fun to_assets_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        mul_div_down(arg0, arg1 + 1, arg2 + 1000000)
    }

    fun to_assets_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        mul_div_up(arg0, arg1 + 1, arg2 + 1000000)
    }

    fun to_shares_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        mul_div_down(arg0, arg2 + 1000000, arg1 + 1)
    }

    fun to_shares_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        mul_div_up(arg0, arg2 + 1000000, arg1 + 1)
    }

    fun to_supply_assets(arg0: u128, arg1: u128, arg2: u128) : u128 {
        mul_div_down(arg0, arg1 + 1, arg2 + 1)
    }

    fun to_supply_shares(arg0: u128, arg1: u128, arg2: u128) : u128 {
        mul_div_down(arg0, arg2 + 1, arg1 + 1)
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut Market<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_unlocked<T0, T1, T2>(arg0);
        let v0 = (0x2::coin::value<T2>(&arg1) as u128);
        assert!(v0 != 0, 20);
        accrue<T0, T1, T2>(arg0, arg2);
        let v1 = to_supply_assets(v0, arg0.total_supply_assets, supply_shares<T0, T1, T2>(arg0));
        assert!(v1 != 0, 20);
        assert!((v1 as u64) <= 0x2::balance::value<T1>(&arg0.loan), 21);
        arg0.total_supply_assets = arg0.total_supply_assets - v1;
        0x2::coin::burn<T2>(&mut arg0.treasury, arg1);
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::withdrawn(0x2::object::id<Market<T0, T1, T2>>(arg0), v1, v0, event_state<T0, T1, T2>(arg0));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.loan, (v1 as u64)), arg3)
    }

    public fun withdraw_collateral<T0, T1, T2>(arg0: &mut Market<T0, T1, T2>, arg1: &Position, arg2: u64, arg3: 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::Price, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_unlocked<T0, T1, T2>(arg0);
        assert!(arg2 != 0, 20);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg0.collateral), 21);
        assert_position<T0, T1, T2>(arg0, arg1);
        accrue<T0, T1, T2>(arg0, arg4);
        let (v0, v1) = checked_price<T0, T1, T2>(arg0, arg3);
        let v2 = to_shares_up((arg2 as u128), arg0.total_collateral_assets, arg0.total_collateral_shares);
        let v3 = 0x2::object::id<Position>(arg1);
        let v4 = 0x2::table::borrow<0x2::object::ID, Account>(&arg0.accounts, v3);
        let v5 = v4.borrow_shares;
        let v6 = v4.collateral_shares;
        assert!(v2 <= v6, 22);
        let v7 = arg0.total_collateral_assets - (arg2 as u128);
        let v8 = arg0.total_collateral_shares - v2;
        let v9 = v6 - v2;
        assert_healthy(v5, to_assets_down(v9, v7, v8), v0, arg0.lltv, arg0.total_borrow_assets, arg0.total_borrow_shares);
        arg0.total_collateral_assets = v7;
        arg0.total_collateral_shares = v8;
        0x2::table::borrow_mut<0x2::object::ID, Account>(&mut arg0.accounts, v3).collateral_shares = v9;
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::collateral_withdrawn(0x2::object::id<Market<T0, T1, T2>>(arg0), v3, (arg2 as u128), v2, v1, account_state<T0, T1, T2>(arg0, v3), event_state<T0, T1, T2>(arg0));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.collateral, arg2), arg5)
    }

    public fun withdraw_fee<T0, T1, T2>(arg0: &mut Market<T0, T1, T2>, arg1: &0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_acl::AdminWitness, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_unlocked<T0, T1, T2>(arg0);
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_acl::assert_has_role(arg1, 1);
        accrue<T0, T1, T2>(arg0, arg2);
        assert!(arg0.fee_shares != 0, 20);
        let v0 = arg0.fee_shares;
        let v1 = to_supply_assets(v0, arg0.total_supply_assets, supply_shares<T0, T1, T2>(arg0));
        assert!(v1 <= (0x2::balance::value<T1>(&arg0.loan) as u128), 21);
        arg0.total_supply_assets = arg0.total_supply_assets - v1;
        arg0.fee_shares = 0;
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::fee_withdrawn(0x2::object::id<Market<T0, T1, T2>>(arg0), v1, v0, event_state<T0, T1, T2>(arg0));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.loan, (v1 as u64)), arg3)
    }

    fun zero_account_state() : 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::AccountState {
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::events::account_state(0, 0, 0, 0)
    }

    // decompiled from Move bytecode v7
}

