module 0x9f39a102363cec6218392c2e22208b3e05972ecc87af5daa62bac7015bf3b8dc::ONE {
    struct ONE has drop {
        dummy_field: bool,
    }

    struct Trove has drop, store {
        collateral: u64,
        debt: u64,
    }

    struct SP has drop, store {
        initial_balance: u64,
        snapshot_product: u128,
        snapshot_index_one: u128,
        snapshot_index_coll: u128,
    }

    struct OriginCap has key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<ONE>,
        fee_pool: 0x2::balance::Balance<ONE>,
        sp_pool: 0x2::balance::Balance<ONE>,
        sp_coll_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        reserve_coll: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury_coll: 0x2::balance::Balance<0x2::sui::SUI>,
        troves: 0x2::table::Table<address, Trove>,
        sp_positions: 0x2::table::Table<address, SP>,
        total_debt: u64,
        total_sp: u64,
        product_factor: u128,
        reward_index_one: u128,
        reward_index_coll: u128,
        sealed: bool,
    }

    struct TroveOpened has copy, drop {
        user: address,
        new_collateral: u64,
        new_debt: u64,
        added_debt: u64,
    }

    struct CollateralAdded has copy, drop {
        user: address,
        amount: u64,
    }

    struct TroveClosed has copy, drop {
        user: address,
        collateral: u64,
        debt: u64,
    }

    struct Redeemed has copy, drop {
        user: address,
        target: address,
        one_amt: u64,
        coll_out: u64,
    }

    struct Liquidated has copy, drop {
        liquidator: address,
        target: address,
        debt: u64,
        coll_to_liquidator: u64,
        coll_to_sp: u64,
        coll_to_reserve: u64,
        coll_to_target: u64,
    }

    struct SPDeposited has copy, drop {
        user: address,
        amount: u64,
    }

    struct SPWithdrew has copy, drop {
        user: address,
        amount: u64,
    }

    struct SPClaimed has copy, drop {
        user: address,
        one_amt: u64,
        coll_amt: u64,
    }

    struct ReserveRedeemed has copy, drop {
        user: address,
        one_amt: u64,
        coll_out: u64,
    }

    struct FeeBurned has copy, drop {
        amount: u64,
    }

    struct CapDestroyed has copy, drop {
        caller: address,
        timestamp_ms: u64,
    }

    struct RewardSaturated has copy, drop {
        user: address,
        pending_one_truncated: bool,
        pending_coll_truncated: bool,
    }

    public fun add_collateral(arg0: &mut Registry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 6);
        assert!(0x2::table::contains<address, Trove>(&arg0.troves, v0), 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury_coll, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v2 = 0x2::table::borrow_mut<address, Trove>(&mut arg0.troves, v0);
        v2.collateral = v2.collateral + v1;
        let v3 = CollateralAdded{
            user   : v0,
            amount : v1,
        };
        0x2::event::emit<CollateralAdded>(v3);
    }

    public fun close_cost(arg0: &Registry, arg1: address) : u64 {
        if (0x2::table::contains<address, Trove>(&arg0.troves, arg1)) {
            0x2::table::borrow<address, Trove>(&arg0.troves, arg1).debt
        } else {
            0
        }
    }

    public fun close_trove(arg0: &mut Registry, arg1: 0x2::coin::Coin<ONE>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Trove>(&arg0.troves, v0), 2);
        let Trove {
            collateral : v1,
            debt       : v2,
        } = 0x2::table::remove<address, Trove>(&mut arg0.troves, v0);
        if (v2 > 0) {
            assert!(0x2::coin::value<ONE>(&arg1) >= v2, 6);
            0x2::coin::burn<ONE>(&mut arg0.treasury, 0x2::coin::split<ONE>(&mut arg1, v2, arg2));
        };
        if (0x2::coin::value<ONE>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ONE>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<ONE>(arg1);
        };
        arg0.total_debt = arg0.total_debt - v2;
        let v3 = TroveClosed{
            user       : v0,
            collateral : v1,
            debt       : v2,
        };
        0x2::event::emit<TroveClosed>(v3);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury_coll, v1), arg2)
    }

    public fun close_trove_entry(arg0: &mut Registry, arg1: 0x2::coin::Coin<ONE>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = close_trove(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun destroy_cap(arg0: OriginCap, arg1: &mut Registry, arg2: 0x2::package::UpgradeCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.sealed, 18);
        let OriginCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::package::make_immutable(arg2);
        arg1.sealed = true;
        let v1 = CapDestroyed{
            caller       : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CapDestroyed>(v1);
    }

    fun init(arg0: ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ONE>(arg0, 8, 0x1::string::utf8(b"ONE"), 0x1::string::utf8(b"1"), 0x1::string::utf8(b"Immutable CDP-backed stablecoin on Sui (SUI-collateralized)"), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ONE>(v0, arg1);
        let v2 = Registry{
            id                : 0x2::object::new(arg1),
            treasury          : v1,
            fee_pool          : 0x2::balance::zero<ONE>(),
            sp_pool           : 0x2::balance::zero<ONE>(),
            sp_coll_pool      : 0x2::balance::zero<0x2::sui::SUI>(),
            reserve_coll      : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury_coll     : 0x2::balance::zero<0x2::sui::SUI>(),
            troves            : 0x2::table::new<address, Trove>(arg1),
            sp_positions      : 0x2::table::new<address, SP>(arg1),
            total_debt        : 0,
            total_sp          : 0,
            product_factor    : 1000000000000000000,
            reward_index_one  : 0,
            reward_index_coll : 0,
            sealed            : false,
        };
        0x2::transfer::share_object<Registry>(v2);
        let v3 = OriginCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OriginCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun is_sealed(arg0: &Registry) : bool {
        arg0.sealed
    }

    public fun liquidate(arg0: &mut Registry, arg1: address, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::table::contains<address, Trove>(&arg0.troves, arg1), 7);
        let v0 = price_8dec(arg2, arg3);
        let v1 = 0x2::table::borrow<address, Trove>(&arg0.troves, arg1);
        let v2 = v1.debt;
        let v3 = v1.collateral;
        assert!((v3 as u128) * v0 / 1000000000 * 10000 < 15000 * (v2 as u128), 8);
        assert!(arg0.total_sp > v2, 9);
        let v4 = arg0.total_sp;
        let v5 = arg0.product_factor * ((v4 - v2) as u128) / (v4 as u128);
        assert!(v5 >= 1000000000, 14);
        let v6 = (v2 as u128) * (1000 as u128) / 10000;
        let v7 = ((v2 as u128) + v6) * 1000000000 / v0;
        let v8 = (v3 as u128);
        let v9 = if (v7 > v8) {
            v8
        } else {
            v7
        };
        let v10 = (v9 as u64);
        let v11 = v6 * (2500 as u128) / 10000 * 1000000000 / v0;
        let v12 = (v10 as u128);
        let v13 = if (v11 > v12) {
            v12
        } else {
            v11
        };
        let v14 = (v13 as u64);
        let v15 = v12 - (v14 as u128);
        let v16 = v6 * (2500 as u128) / 10000 * 1000000000 / v0;
        let v17 = if (v16 > v15) {
            v15
        } else {
            v16
        };
        let v18 = (v17 as u64);
        let v19 = v10 - v14 - v18;
        let v20 = v3 - v10;
        0x2::table::remove<address, Trove>(&mut arg0.troves, arg1);
        arg0.total_debt = arg0.total_debt - v2;
        0x2::coin::burn<ONE>(&mut arg0.treasury, 0x2::coin::from_balance<ONE>(0x2::balance::split<ONE>(&mut arg0.sp_pool, v2), arg4));
        arg0.reward_index_coll = arg0.reward_index_coll + (v19 as u128) * arg0.product_factor / (v4 as u128);
        arg0.product_factor = v5;
        arg0.total_sp = v4 - v2;
        let v21 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury_coll, v10);
        if (v18 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve_coll, 0x2::balance::split<0x2::sui::SUI>(&mut v21, v18));
        };
        if (v19 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.sp_coll_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v21, v19));
        };
        if (v20 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury_coll, v20), arg4), arg1);
        };
        let v22 = Liquidated{
            liquidator         : 0x2::tx_context::sender(arg4),
            target             : arg1,
            debt               : v2,
            coll_to_liquidator : v14,
            coll_to_sp         : v19,
            coll_to_reserve    : v18,
            coll_to_target     : v20,
        };
        0x2::event::emit<Liquidated>(v22);
        0x2::coin::from_balance<0x2::sui::SUI>(v21, arg4)
    }

    public fun liquidate_entry(arg0: &mut Registry, arg1: address, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = liquidate(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg4));
    }

    fun now_secs(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun open_trove(arg0: &mut Registry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ONE> {
        assert!(arg2 >= 100000000, 3);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::table::contains<address, Trove>(&arg0.troves, v0);
        let (v2, v3) = if (v1) {
            let v4 = 0x2::table::borrow<address, Trove>(&arg0.troves, v0);
            (v4.collateral, v4.debt)
        } else {
            (0, 0)
        };
        let v5 = v2 + 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v6 = v3 + arg2;
        assert!((v5 as u128) * price_8dec(arg3, arg4) / 1000000000 * 10000 >= 20000 * (v6 as u128), 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury_coll, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v7 = (((arg2 as u128) * (100 as u128) / 10000) as u64);
        let v8 = 0x2::coin::mint<ONE>(&mut arg0.treasury, arg2 - v7, arg5);
        let v9 = 0x2::coin::into_balance<ONE>(0x2::coin::mint<ONE>(&mut arg0.treasury, v7, arg5));
        route_fee(arg0, v9, arg5);
        if (v1) {
            let v10 = 0x2::table::borrow_mut<address, Trove>(&mut arg0.troves, v0);
            v10.collateral = v5;
            v10.debt = v6;
        } else {
            let v11 = Trove{
                collateral : v5,
                debt       : v6,
            };
            0x2::table::add<address, Trove>(&mut arg0.troves, v0, v11);
        };
        arg0.total_debt = arg0.total_debt + arg2;
        let v12 = TroveOpened{
            user           : v0,
            new_collateral : v5,
            new_debt       : v6,
            added_debt     : arg2,
        };
        0x2::event::emit<TroveOpened>(v12);
        v8
    }

    public fun open_trove_entry(arg0: &mut Registry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = open_trove(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<ONE>>(v0, 0x2::tx_context::sender(arg5));
    }

    fun pow10(arg0: u64) : u128 {
        assert!(arg0 <= 38, 13);
        let v0 = 1;
        while (arg0 > 0) {
            v0 = v0 * 10;
            arg0 = arg0 - 1;
        };
        v0
    }

    fun price_8dec(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) : u128 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1) == x"23d7315113f5b1d3ba7a83604c44b94d79f4fd69af77f804fc7f920a6dc65744", 17);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg1, 60);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v2);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v2);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v2);
        let v6 = now_secs(arg1);
        assert!(v5 + 60 >= v6, 4);
        assert!(v5 <= v6 + 10, 4);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4), 15);
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v4);
        assert!(v7 <= 18, 12);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3), 16);
        let v8 = (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3) as u128);
        assert!(v8 > 0, 11);
        assert!((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v2) as u128) * 10000 <= (200 as u128) * v8, 19);
        let v9 = if (v7 >= 8) {
            v8 / pow10(v7 - 8)
        } else {
            v8 * pow10(8 - v7)
        };
        assert!(v9 > 0, 11);
        v9
    }

    public fun price_view(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) : u128 {
        price_8dec(arg0, arg1)
    }

    public fun read_warning() : vector<u8> {
        b"ONE is an immutable stablecoin contract on Sui that depends on Pyth Network's on-chain price feed for SUI/USD. If Pyth degrades or misrepresents its oracle, ONE's peg mechanism breaks deterministically - users can wind down via self-close without any external assistance, but new mint/redeem operations become unreliable or frozen. one is immutable = bug is real. Audit this code yourself before interacting. KNOWN LIMITATIONS: (1) Stability Pool enters frozen state when product_factor would drop below 1e9 - protocol aborts further liquidations rather than corrupt SP accounting, accepting bad-debt accumulation past the threshold. (2) Sustained large-scale activity over decades may asymptotically exceed u64 bounds on pending SP rewards. (3) Liquidation seized collateral is distributed in priority: liquidator bonus first (nominal 2.5 percent of debt value, being 25 percent of the 10 percent liquidation bonus), then 2.5 percent reserve share (also 25 percent of bonus), then SP absorbs the remainder and the debt burn. At CR roughly 110% to 150% the SP alone covers the collateral shortfall. At CR below ~5% the liquidator may take the entire remaining collateral, reserve and SP receive zero, and SP still absorbs the full debt burn. (4) 25 percent of each fee is burned, creating a structural 0.25 percent aggregate supply-vs-debt gap per cycle (which rises to 1 percent during SP-empty windows because the remaining 75 percent also burns); individual debtors also face a 1 percent per-trove shortfall because only 99 percent is minted while 100 percent is needed to close - full protocol wind-down requires secondary-market ONE for the last debt closure. (5) Self-redemption (redeem against own trove) is allowed and behaves as partial debt repayment plus collateral withdrawal with a 1 percent fee. (6) Pyth is pull-based on Sui - callers must refresh the SUI/USD PriceInfoObject via pyth::update_single_price_feed within the same PTB, or oracle-dependent entries abort with E_STALE. (7) Extreme low-price regimes may cause transient aborts in redeem paths when requested amounts exceed u64 output bounds; use smaller amounts and retry. (8) ORACLE UPGRADE RISK (Sui-specific): Pyth Sui (pkg 0x04e20ddf..., state 0x1f931023...) is NOT cryptographically immutable. Its UpgradeCap sits inside shared State with policy=0 (compatible), controlled by Pyth DAO via Wormhole VAA governance. Sui's compatibility checker prevents public-function signature regressions, but does NOT prevent feed-id deregistration, Price struct field reshuffling, or Wormhole state rotation - any of which could brick this consumer. No admin escape once this package is sealed. Accept as external-dependency risk. Oracle-free escape hatches remain fully open: close_trove lets any trove owner reclaim their collateral by burning the full trove debt in ONE (acquiring the 1 percent close deficit via secondary market if needed); add_collateral lets owners top up existing troves without touching the oracle; sp_deposit, sp_withdraw, and sp_claim let SP depositors manage and exit their positions and claim any rewards accumulated before the freeze. Protocol-owned SUI held in reserve_coll becomes permanently locked because redeem_from_reserve requires the oracle. No admin override exists; the freeze is final. (9) REDEMPTION vs LIQUIDATION are two separate mechanisms. liquidate is health-gated (requires CR below 150 percent) and applies a penalty bonus to the liquidator, the reserve, and the SP; healthy troves cannot be liquidated by anyone. redeem has no health gate on target and executes a value-neutral swap at oracle spot price - the target's debt decreases by net ONE while their collateral decreases by net times 1e9 over price SUI (Sui native is 9 decimals), so the target retains full value at spot. Redemption is the protocol peg-anchor: when ONE trades below 1 USD on secondary market, any holder can burn ONE supply by redeeming for SUI, pushing the peg back up. The target is caller-specified; there is no sorted-by-CR priority, unlike Liquity V1's sorted list - the economic result for the target is identical to Liquity (made whole at spot), only the redemption ordering differs, and ordering is a peg-efficiency optimization rather than a safety property. Borrowers who want guaranteed long-term SUI exposure without the possibility of redemption-induced position conversion should not use ONE troves - use a non-CDP lending protocol instead. Losing optionality under redemption is not the same as losing value: the target is economically indifferent at spot."
    }

    public fun redeem(arg0: &mut Registry, arg1: 0x2::coin::Coin<ONE>, arg2: address, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<ONE>(&arg1);
        assert!(v1 >= 100000000, 6);
        assert!(0x2::table::contains<address, Trove>(&arg0.troves, arg2), 7);
        let v2 = (((v1 as u128) * (100 as u128) / 10000) as u64);
        let v3 = v1 - v2;
        let v4 = (((v3 as u128) * 1000000000 / price_8dec(arg3, arg4)) as u64);
        let v5 = 0x2::table::borrow_mut<address, Trove>(&mut arg0.troves, arg2);
        assert!(v5.debt >= v3, 7);
        assert!(v5.collateral >= v4, 1);
        v5.debt = v5.debt - v3;
        v5.collateral = v5.collateral - v4;
        assert!(v5.debt == 0 || v5.debt >= 100000000, 3);
        assert!(v5.debt == 0 || v5.collateral > 0, 1);
        0x2::coin::burn<ONE>(&mut arg0.treasury, arg1);
        let v6 = 0x2::coin::into_balance<ONE>(0x2::coin::split<ONE>(&mut arg1, v2, arg5));
        route_fee(arg0, v6, arg5);
        arg0.total_debt = arg0.total_debt - v3;
        let v7 = Redeemed{
            user     : v0,
            target   : arg2,
            one_amt  : v1,
            coll_out : v4,
        };
        0x2::event::emit<Redeemed>(v7);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury_coll, v4), arg5)
    }

    public fun redeem_entry(arg0: &mut Registry, arg1: 0x2::coin::Coin<ONE>, arg2: address, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun redeem_from_reserve(arg0: &mut Registry, arg1: 0x2::coin::Coin<ONE>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<ONE>(&arg1);
        assert!(v1 >= 100000000, 6);
        let v2 = (((v1 as u128) * (100 as u128) / 10000) as u64);
        let v3 = ((((v1 - v2) as u128) * 1000000000 / price_8dec(arg2, arg3)) as u64);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.reserve_coll) >= v3, 10);
        0x2::coin::burn<ONE>(&mut arg0.treasury, arg1);
        let v4 = 0x2::coin::into_balance<ONE>(0x2::coin::split<ONE>(&mut arg1, v2, arg4));
        route_fee(arg0, v4, arg4);
        let v5 = ReserveRedeemed{
            user     : v0,
            one_amt  : v1,
            coll_out : v3,
        };
        0x2::event::emit<ReserveRedeemed>(v5);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reserve_coll, v3), arg4)
    }

    public fun redeem_from_reserve_entry(arg0: &mut Registry, arg1: 0x2::coin::Coin<ONE>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_from_reserve(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun reserve_balance(arg0: &Registry) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.reserve_coll)
    }

    fun route_fee(arg0: &mut Registry, arg1: 0x2::balance::Balance<ONE>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<ONE>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<ONE>(arg1);
            return
        };
        let v1 = (((v0 as u128) * 2500 / 10000) as u64);
        if (v1 > 0) {
            0x2::coin::burn<ONE>(&mut arg0.treasury, 0x2::coin::from_balance<ONE>(0x2::balance::split<ONE>(&mut arg1, v1), arg2));
            let v2 = FeeBurned{amount: v1};
            0x2::event::emit<FeeBurned>(v2);
        };
        let v3 = 0x2::balance::value<ONE>(&arg1);
        if (v3 == 0) {
            0x2::balance::destroy_zero<ONE>(arg1);
            return
        };
        if (arg0.total_sp == 0) {
            0x2::coin::burn<ONE>(&mut arg0.treasury, 0x2::coin::from_balance<ONE>(arg1, arg2));
        } else {
            0x2::balance::join<ONE>(&mut arg0.fee_pool, arg1);
            arg0.reward_index_one = arg0.reward_index_one + (v3 as u128) * arg0.product_factor / (arg0.total_sp as u128);
        };
    }

    public fun sp_claim(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, SP>(&arg0.sp_positions, v0), 5);
        sp_settle(arg0, v0, arg1);
    }

    public fun sp_deposit(arg0: &mut Registry, arg1: 0x2::coin::Coin<ONE>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<ONE>(&arg1);
        assert!(v0 > 0, 6);
        let v1 = 0x2::tx_context::sender(arg2);
        0x2::balance::join<ONE>(&mut arg0.sp_pool, 0x2::coin::into_balance<ONE>(arg1));
        if (arg0.total_sp == 0) {
            arg0.product_factor = 1000000000000000000;
        };
        if (0x2::table::contains<address, SP>(&arg0.sp_positions, v1)) {
            sp_settle(arg0, v1, arg2);
            let v2 = 0x2::table::borrow_mut<address, SP>(&mut arg0.sp_positions, v1);
            v2.initial_balance = v2.initial_balance + v0;
        } else {
            let v3 = SP{
                initial_balance     : v0,
                snapshot_product    : arg0.product_factor,
                snapshot_index_one  : arg0.reward_index_one,
                snapshot_index_coll : arg0.reward_index_coll,
            };
            0x2::table::add<address, SP>(&mut arg0.sp_positions, v1, v3);
        };
        arg0.total_sp = arg0.total_sp + v0;
        let v4 = SPDeposited{
            user   : v1,
            amount : v0,
        };
        0x2::event::emit<SPDeposited>(v4);
    }

    public fun sp_of(arg0: &Registry, arg1: address) : (u64, u64, u64) {
        if (0x2::table::contains<address, SP>(&arg0.sp_positions, arg1)) {
            let v3 = 0x2::table::borrow<address, SP>(&arg0.sp_positions, arg1);
            ((((v3.initial_balance as u256) * (arg0.product_factor as u256) / (v3.snapshot_product as u256)) as u64), ((((arg0.reward_index_one - v3.snapshot_index_one) as u256) * (v3.initial_balance as u256) / (v3.snapshot_product as u256)) as u64), ((((arg0.reward_index_coll - v3.snapshot_index_coll) as u256) * (v3.initial_balance as u256) / (v3.snapshot_product as u256)) as u64))
        } else {
            (0, 0, 0)
        }
    }

    fun sp_settle(arg0: &mut Registry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow<address, SP>(&arg0.sp_positions, arg1);
        let v1 = v0.snapshot_product;
        let v2 = v0.snapshot_index_coll;
        let v3 = v0.initial_balance;
        if (v1 == 0 || v3 == 0) {
            let v4 = 0x2::table::borrow_mut<address, SP>(&mut arg0.sp_positions, arg1);
            v4.snapshot_product = arg0.product_factor;
            v4.snapshot_index_one = arg0.reward_index_one;
            v4.snapshot_index_coll = arg0.reward_index_coll;
            return
        };
        let v5 = 18446744073709551615;
        let v6 = ((arg0.reward_index_one - v0.snapshot_index_one) as u256) * (v3 as u256) / (v1 as u256);
        let v7 = ((arg0.reward_index_coll - v2) as u256) * (v3 as u256) / (v1 as u256);
        let v8 = (v3 as u256) * (arg0.product_factor as u256) / (v1 as u256);
        let v9 = v6 > v5;
        let v10 = v7 > v5;
        let v11 = if (v9) {
            v5
        } else {
            v6
        };
        let v12 = (v11 as u64);
        let v13 = if (v10) {
            v5
        } else {
            v7
        };
        let v14 = (v13 as u64);
        let v15 = if (v8 > v5) {
            v5
        } else {
            v8
        };
        if (v9 || v10) {
            let v16 = RewardSaturated{
                user                   : arg1,
                pending_one_truncated  : v9,
                pending_coll_truncated : v10,
            };
            0x2::event::emit<RewardSaturated>(v16);
        };
        let v17 = 0x2::table::borrow_mut<address, SP>(&mut arg0.sp_positions, arg1);
        v17.initial_balance = (v15 as u64);
        v17.snapshot_product = arg0.product_factor;
        v17.snapshot_index_one = arg0.reward_index_one;
        v17.snapshot_index_coll = arg0.reward_index_coll;
        if (v12 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ONE>>(0x2::coin::from_balance<ONE>(0x2::balance::split<ONE>(&mut arg0.fee_pool, v12), arg2), arg1);
        };
        if (v14 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sp_coll_pool, v14), arg2), arg1);
        };
        if (v12 > 0 || v14 > 0) {
            let v18 = SPClaimed{
                user     : arg1,
                one_amt  : v12,
                coll_amt : v14,
            };
            0x2::event::emit<SPClaimed>(v18);
        };
    }

    public fun sp_withdraw(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ONE> {
        assert!(arg1 > 0, 6);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, SP>(&arg0.sp_positions, v0), 5);
        sp_settle(arg0, v0, arg2);
        let v1 = 0x2::table::borrow_mut<address, SP>(&mut arg0.sp_positions, v0);
        assert!(v1.initial_balance >= arg1, 5);
        v1.initial_balance = v1.initial_balance - arg1;
        arg0.total_sp = arg0.total_sp - arg1;
        if (v1.initial_balance == 0) {
            0x2::table::remove<address, SP>(&mut arg0.sp_positions, v0);
        };
        let v2 = SPWithdrew{
            user   : v0,
            amount : arg1,
        };
        0x2::event::emit<SPWithdrew>(v2);
        0x2::coin::from_balance<ONE>(0x2::balance::split<ONE>(&mut arg0.sp_pool, arg1), arg2)
    }

    public fun sp_withdraw_entry(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = sp_withdraw(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<ONE>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun totals(arg0: &Registry) : (u64, u64, u128, u128, u128) {
        (arg0.total_debt, arg0.total_sp, arg0.product_factor, arg0.reward_index_one, arg0.reward_index_coll)
    }

    public fun trove_health(arg0: &Registry, arg1: address, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        if (!0x2::table::contains<address, Trove>(&arg0.troves, arg1)) {
            return (0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, Trove>(&arg0.troves, arg1);
        if (v0.debt == 0) {
            return (v0.collateral, 0, 0)
        };
        (v0.collateral, v0.debt, (((v0.collateral as u128) * price_8dec(arg2, arg3) / 1000000000 * 10000 / (v0.debt as u128)) as u64))
    }

    public fun trove_of(arg0: &Registry, arg1: address) : (u64, u64) {
        if (0x2::table::contains<address, Trove>(&arg0.troves, arg1)) {
            let v2 = 0x2::table::borrow<address, Trove>(&arg0.troves, arg1);
            (v2.collateral, v2.debt)
        } else {
            (0, 0)
        }
    }

    // decompiled from Move bytecode v7
}

