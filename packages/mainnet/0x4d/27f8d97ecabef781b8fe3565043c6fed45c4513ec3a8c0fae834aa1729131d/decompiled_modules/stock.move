module 0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::stock {
    struct StockVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<T0>,
        authority: 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>,
        account: 0x2::object::ID,
        market: 0x2::object::ID,
        base_oracle: 0x2::object::ID,
        collateral_oracle: 0x2::object::ID,
        fees: 0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::fees::Fees<T1>,
    }

    struct PendingMarket<phantom T0> has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<T0>,
        protocol_admin: address,
    }

    struct MarketStaged has copy, drop {
        pending_market: 0x2::object::ID,
        treasury_cap: 0x2::object::ID,
        metadata_cap: 0x2::object::ID,
        metadata_owner: address,
        protocol_admin: address,
    }

    struct Created has copy, drop {
        vault: 0x2::object::ID,
        account: 0x2::object::ID,
        market: 0x2::object::ID,
        stock_type: 0x1::ascii::String,
        collateral_type: 0x1::ascii::String,
        fee_recipient: address,
        redemption_fee_bps: u64,
    }

    struct Minted has copy, drop {
        vault: 0x2::object::ID,
        sender: address,
        deposit: u64,
        shares: u64,
        base_added_b9: u64,
        equity_after: u64,
        supply_after: u64,
    }

    struct Burned has copy, drop {
        vault: 0x2::object::ID,
        sender: address,
        shares: u64,
        collateral_out: u64,
        redemption_fee: u64,
        base_removed_b9: u64,
        supply_after: u64,
    }

    struct Rebalanced has copy, drop {
        vault: 0x2::object::ID,
        base_removed_b9: u64,
        equity_before: u64,
        equity_after: u64,
    }

    struct FeesCollected has copy, drop {
        vault: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    public fun burn<T0, T1>(arg0: &0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::Protocol, arg1: &mut StockVault<T0, T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::assert_current(arg0, 2);
        redeem<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, false)
    }

    public fun mint<T0, T1>(arg0: &0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::Protocol, arg1: &mut StockVault<T0, T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::assert_current(arg0, 2);
        validate<T0, T1>(arg1, arg2, &arg4, arg5, arg6, arg10, arg11);
        let v0 = &mut arg4;
        settle<T1>(v0, arg2, arg5, arg6, arg11);
        let (v1, v2) = prices<T1>(&arg4, arg5, arg6, arg11);
        let v3 = equity<T1>(&arg4, arg2, v1, v2);
        let v4 = 0x2::coin::total_supply<T0>(&arg1.treasury);
        assert!(v4 == 0 || v3 > 0, 14);
        let v5 = base_size<T1>(&arg4, arg2);
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::accounting::assert_units(v5, v4);
        let v6 = 0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::accounting::unit_mint(arg8, arg9);
        let v7 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg4);
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::accounting::assert_order_minimum(arg8, 0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::accounting::unit_step(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(v7)), v1, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::min_order_usd_value(v7));
        let v8 = 0x2::coin::value<T1>(&arg7);
        assert!(v8 > 0, 14);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::deposit_collateral<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, &arg1.authority, arg3, arg7);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::allocate_collateral<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg4, &arg1.authority, arg2, v8);
        let v9 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg4, &arg1.authority, arg2, arg5, arg6, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg11, arg12);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_market_order<T1>(&mut v9, false, arg8, false);
        let (v10, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(v9, &arg1.authority, arg2, false, false);
        let v12 = v10;
        let v13 = base_size<T1>(&v12, arg2);
        assert!(v13 == v5 + arg8, 13);
        let v14 = equity<T1>(&v12, arg2, v1, v2);
        let v15 = if (v4 == 0) {
            assert!(v3 == 0, 14);
            notional<T1>(&v12, arg2, v1, v2)
        } else {
            0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::accounting::unit_entry_equity(v4, v3, v6)
        };
        assert!(v15 > 0 && v14 >= v3 + v15, 14);
        let v16 = v14 - v3 - v15;
        if (v16 > 0) {
            let v17 = &mut v12;
            let v18 = withdraw<T1>(v17, arg2, arg3, &arg1.authority, arg5, arg6, v16, arg11, arg12);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v18, 0x2::tx_context::sender(arg12));
        };
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::accounting::assert_units(v13, v4 + v6);
        let v19 = Minted{
            vault         : 0x2::object::id<StockVault<T0, T1>>(arg1),
            sender        : 0x2::tx_context::sender(arg12),
            deposit       : v8,
            shares        : v6,
            base_added_b9 : arg8,
            equity_after  : v3 + v15,
            supply_after  : v4 + v6,
        };
        0x2::event::emit<Minted>(v19);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(v12);
        0x2::coin::mint<T0>(&mut arg1.treasury, v6, arg12)
    }

    public fun activate<T0, T1>(arg0: &0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::Protocol, arg1: PendingMarket<T0>, arg2: &0x2::coin_registry::Currency<T0>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::assert_current(arg0, 2);
        assert!(0x2::tx_context::sender(arg10) == arg1.protocol_admin, 10);
        assert!(0x2::coin_registry::decimals<T0>(arg2) == 6 && 0x2::coin::get_decimals<T1>(arg3) == 6, 10);
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg2) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg1.treasury)), 10);
        let PendingMarket {
            id             : v0,
            treasury       : v1,
            protocol_admin : _,
        } = arg1;
        0x2::object::delete(v0);
        create_vault<T0, T1>(v1, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun activate_with_currency<T0, T1>(arg0: &0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::Protocol, arg1: PendingMarket<T0>, arg2: &0x2::coin_registry::Currency<T0>, arg3: &0x2::coin_registry::Currency<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::assert_current(arg0, 2);
        assert!(0x2::tx_context::sender(arg10) == arg1.protocol_admin, 10);
        assert!(0x2::coin_registry::decimals<T0>(arg2) == 6 && 0x2::coin_registry::decimals<T1>(arg3) == 6, 10);
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg2) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg1.treasury)), 10);
        let PendingMarket {
            id             : v0,
            treasury       : v1,
            protocol_admin : _,
        } = arg1;
        0x2::object::delete(v0);
        create_vault<T0, T1>(v1, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    fun assert_open<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>) {
        assert!(!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_frozen<T0>(arg0) && !0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_market_paused<T0>(arg0), 16);
    }

    fun base_size<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>) : u64 {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1));
        assert!(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::is_long_or_flat(v0) && 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v0) == 0, 12);
        let (v1, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v0);
        assert!(!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v1) && v1 % 1000000000 == 0, 12);
        ((v1 / 1000000000) as u64)
    }

    public fun bindings<T0, T1>(arg0: &0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::Protocol, arg1: &StockVault<T0, T1>) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::assert_current(arg0, 2);
        (arg1.account, arg1.market, arg1.base_oracle, arg1.collateral_oracle)
    }

    public fun collect_fees<T0, T1>(arg0: &0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::Protocol, arg1: &mut StockVault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::assert_current(arg0, 2);
        let (v0, v1) = 0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::fees::collect<T1>(&mut arg1.fees, arg2);
        let v2 = v0;
        let v3 = FeesCollected{
            vault     : 0x2::object::id<StockVault<T0, T1>>(arg1),
            recipient : v1,
            amount    : 0x2::coin::value<T1>(&v2),
        };
        0x2::event::emit<FeesCollected>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v1);
    }

    public fun create<T0, T1>(arg0: &0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::Protocol, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::assert_current(arg0, 2);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 10);
        assert!(0x2::coin::get_decimals<T0>(arg2) == 6 && 0x2::coin::get_decimals<T1>(arg3) == 6, 10);
        create_vault<T0, T1>(arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    fun create_vault<T0, T1>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<T0>(&arg0) == 0, 10);
        assert_open<T1>(arg2);
        let (_, _) = prices<T1>(arg2, arg3, arg4, arg6);
        let (v2, v3, v4) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::create_account<T1>(arg1, arg7);
        let v5 = v4;
        let v6 = v2;
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::create_market_position<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, &v5, &v6);
        let v7 = 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(&v6);
        let v8 = StockVault<T0, T1>{
            id                : 0x2::object::new(arg7),
            treasury          : arg0,
            authority         : v5,
            account           : v7,
            market            : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg2),
            base_oracle       : 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg3),
            collateral_oracle : 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg4),
            fees              : 0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::fees::new<T1>(arg5),
        };
        let v9 = Created{
            vault              : 0x2::object::id<StockVault<T0, T1>>(&v8),
            account            : v7,
            market             : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg2),
            stock_type         : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            collateral_type    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            fee_recipient      : arg5,
            redemption_fee_bps : 25,
        };
        0x2::event::emit<Created>(v9);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::consume_policy_and_share_account<T1>(v6, v3);
        0x2::transfer::share_object<StockVault<T0, T1>>(v8);
    }

    public fun effective_supply<T0, T1>(arg0: &0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::Protocol, arg1: &StockVault<T0, T1>, arg2: &0x2::clock::Clock) : u64 {
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::assert_current(arg0, 2);
        0x2::coin::total_supply<T0>(&arg1.treasury)
    }

    fun equity<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: u256, arg3: u256) : u64 {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1));
        let v1 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::scaling_factor(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg0));
        let v2 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v0), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::unrealized_pnl(v0, arg2), arg3)), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T0>(arg1), v1));
        assert!(!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v2), 14);
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(v2, v1)
    }

    public fun fee_info<T0, T1>(arg0: &0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::Protocol, arg1: &StockVault<T0, T1>) : (address, u64, u64) {
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::assert_current(arg0, 2);
        let (v0, v1) = 0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::fees::info<T1>(&arg1.fees);
        (v0, v1, 25)
    }

    public fun maintain<T0, T1>(arg0: &0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::Protocol, arg1: &StockVault<T0, T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : bool {
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::assert_current(arg0, 2);
        validate<T0, T1>(arg1, arg2, &arg3, arg4, arg5, arg6, arg7);
        let (v0, v1) = prices<T1>(&arg3, arg4, arg5, arg7);
        let (v2, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::funding_params(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg3));
        let v4 = &mut arg3;
        settle<T1>(v4, arg2, arg4, arg5, arg7);
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::accounting::assert_units(base_size<T1>(&arg3, arg2), 0x2::coin::total_supply<T0>(&arg1.treasury));
        let (v5, v6) = prices<T1>(&arg3, arg4, arg5, arg7);
        assert!(0x2::coin::total_supply<T0>(&arg1.treasury) == 0 || equity<T1>(&arg3, arg2, v5, v6) > 0, 14);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(arg3);
        0x2::clock::timestamp_ms(arg7) >= 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::next_funding_update_time(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::funding_last_upd_ms(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_state<T1>(&arg3)), v2) || equity<T1>(&arg3, arg2, v5, v6) != equity<T1>(&arg3, arg2, v0, v1)
    }

    public fun minimum_units<T0>(arg0: &0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::Protocol, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x2::clock::Clock) : (u64, u64, u256) {
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::assert_current(arg0, 2);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg1);
        let v1 = 0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::accounting::unit_step(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(v0));
        let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::min_order_usd_value(v0);
        (0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::accounting::order_minimum(v1, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_oracle_price(v0, arg2, arg3), v2) / 1000, v1 / 1000, v2)
    }

    fun notional<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: u256, arg3: u256) : u64 {
        let (v0, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1)));
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v0, arg2), arg3), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::scaling_factor(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg0)))
    }

    fun prices<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x2::clock::Clock) : (u256, u256) {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg0);
        let v1 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_oracle_price(v0, arg1, arg3);
        let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_oracle_price(v0, arg2, arg3);
        let v3 = if (!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v1)) {
            if (v1 > 0) {
                if (!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v2)) {
                    v2 > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 14);
        (v1, v2)
    }

    public fun quote_mint_size<T0, T1>(arg0: &0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::Protocol, arg1: &StockVault<T0, T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: u64, arg7: &0x2::clock::Clock) : (u64, u64, u256, u256) {
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::assert_current(arg0, 2);
        validate<T0, T1>(arg1, arg2, &arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg7), arg7);
        let v0 = &mut arg3;
        settle<T1>(v0, arg2, arg4, arg5, arg7);
        let v1 = 0x2::coin::total_supply<T0>(&arg1.treasury);
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::accounting::assert_units(base_size<T1>(&arg3, arg2), v1);
        let (v2, v3) = prices<T1>(&arg3, arg4, arg5, arg7);
        let v4 = equity<T1>(&arg3, arg2, v2, v3);
        let v5 = if (v1 == 0) {
            assert!(v4 == 0, 14);
            (((arg6 as u256) * v3 / v2) as u64)
        } else {
            assert!(v4 > 0, 14);
            (((arg6 as u128) * (v1 as u128) / (v4 as u128)) as u64)
        };
        let v6 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg3);
        let v7 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(v6);
        let v8 = 0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::accounting::unit_step(v7);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(arg3);
        (v5 * 1000 / v8 * v8, v7, v2, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::min_order_usd_value(v6))
    }

    public fun rebalance<T0, T1>(arg0: &0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::Protocol, arg1: &StockVault<T0, T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::assert_current(arg0, 2);
        abort 12
    }

    fun redeem<T0, T1>(arg0: &0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::Protocol, arg1: &mut StockVault<T0, T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext, arg12: bool) : 0x2::coin::Coin<T1> {
        validate<T0, T1>(arg1, arg2, &arg4, arg5, arg6, arg9, arg10);
        let v0 = &mut arg4;
        settle<T1>(v0, arg2, arg5, arg6, arg10);
        let (v1, v2) = prices<T1>(&arg4, arg5, arg6, arg10);
        let v3 = 0x2::coin::value<T0>(&arg7);
        let v4 = 0x2::coin::total_supply<T0>(&arg1.treasury);
        assert!(v3 > 0 && v3 <= v4, 12);
        let v5 = base_size<T1>(&arg4, arg2);
        let v6 = (v5 as u128) == (v4 as u128) * 1000;
        assert!(arg12 != v6, 12);
        let v7 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg4));
        let v8 = if (v6) {
            let v9 = 0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::accounting::unit_base(v3);
            assert!(v9 % v7 == 0, 12);
            v9
        } else if (v5 == 0) {
            0
        } else {
            0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::accounting::close_size(v5, v3, v4, v7)
        };
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::accounting::assert_exit_minimum(v8, v5, v7, v1, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::min_order_usd_value(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg4)));
        let v10 = if (v8 == 0) {
            arg4
        } else {
            let v11 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg4, &arg1.authority, arg2, arg5, arg6, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg10, arg11);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_market_order<T1>(&mut v11, true, v8, true);
            let (v12, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(v11, &arg1.authority, arg2, false, false);
            v12
        };
        let v14 = v10;
        assert!(base_size<T1>(&v14, arg2) == v5 - v8, 13);
        let v15 = 0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::accounting::redeem_amount(v4, v3, equity<T1>(&arg4, arg2, v1, v2), equity<T1>(&v14, arg2, v1, v2), 0);
        let (v16, v17) = 0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::accounting::redemption_amounts(v15, arg8);
        let v18 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T1>(arg2);
        if (v18 < v15) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::deallocate_collateral<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut v14, &arg1.authority, arg2, arg5, arg6, v15 - v18, arg10);
        };
        assert!(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T1>(arg2) >= v15, 15);
        0x2::coin::burn<T0>(&mut arg1.treasury, arg7);
        let v19 = Burned{
            vault           : 0x2::object::id<StockVault<T0, T1>>(arg1),
            sender          : 0x2::tx_context::sender(arg11),
            shares          : v3,
            collateral_out  : v16,
            redemption_fee  : v17,
            base_removed_b9 : v8,
            supply_after    : v4 - v3,
        };
        0x2::event::emit<Burned>(v19);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T1>(v14);
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::fees::charge<T1>(&mut arg1.fees, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::withdraw_collateral<T1>(arg2, &arg1.authority, arg3, v15, arg11), arg8, arg11)
    }

    public fun redeem_impaired<T0, T1>(arg0: &0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::Protocol, arg1: &mut StockVault<T0, T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::assert_current(arg0, 2);
        redeem<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, true)
    }

    fun settle<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock) {
        let (v0, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::funding_params(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg0));
        if (0x2::clock::timestamp_ms(arg4) >= 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::next_funding_update_time(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::funding_last_upd_ms(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_state<T0>(arg0)), v0)) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::update_funding<T0>(arg0, arg2, arg4);
        };
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::settle_position_funding<T0>(arg0, arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1), arg4);
    }

    public fun stage_currency<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin_registry::CurrencyInitializer<T0>, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0 && arg3 != @0x0, 10);
        assert!(0x2::coin::total_supply<T0>(&arg0) == 0, 10);
        let v0 = 0x2::coin_registry::finalize<T0>(arg1, arg4);
        let v1 = PendingMarket<T0>{
            id             : 0x2::object::new(arg4),
            treasury       : arg0,
            protocol_admin : arg2,
        };
        let v2 = MarketStaged{
            pending_market : 0x2::object::id<PendingMarket<T0>>(&v1),
            treasury_cap   : 0x2::object::id<0x2::coin::TreasuryCap<T0>>(&v1.treasury),
            metadata_cap   : 0x2::object::id<0x2::coin_registry::MetadataCap<T0>>(&v0),
            metadata_owner : arg3,
            protocol_admin : arg2,
        };
        0x2::event::emit<MarketStaged>(v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<T0>>(v0, arg3);
        0x2::transfer::share_object<PendingMarket<T0>>(v1);
    }

    public fun supply<T0, T1>(arg0: &0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::Protocol, arg1: &StockVault<T0, T1>) : u64 {
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::upgrade::assert_current(arg0, 2);
        0x2::coin::total_supply<T0>(&arg1.treasury)
    }

    fun validate<T0, T1>(arg0: &StockVault<T0, T1>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: u64, arg6: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 11);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg1) == arg0.account && 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg2) == arg0.market, 10);
        assert!(0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg3) == arg0.base_oracle && 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg4) == arg0.collateral_oracle, 10);
        assert_open<T1>(arg2);
    }

    fun withdraw<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T0>(arg1);
        if (v0 < arg6) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::deallocate_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg0, arg3, arg1, arg4, arg5, arg6 - v0, arg7);
        };
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::withdraw_collateral<T0>(arg1, arg3, arg2, arg6, arg8)
    }

    // decompiled from Move bytecode v7
}

