module 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::registry {
    struct MarketRegistry<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        treasury: 0x2::balance::Balance<T0>,
        market_count: u64,
        fee_bps: u16,
        paused: bool,
        min_bet: u64,
        max_bet: u64,
        version: u64,
    }

    public fun admin<T0>(arg0: &MarketRegistry<T0>) : address {
        arg0.admin
    }

    public fun admin_add_feed<T0>(arg0: &mut MarketRegistry<T0>, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::admin::AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::config::has_feed(&arg0.id, &arg1), 27);
        0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::config::add_feed(&mut arg0.id, arg1, arg2);
        0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::events::emit_feed_added(arg1, arg2);
    }

    public fun admin_collect_fees<T0>(arg0: &mut MarketRegistry<T0>, arg1: &mut 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::Market<T0>, arg2: &0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.treasury, 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::collect_fees<T0>(arg1));
    }

    public fun admin_migrate<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version < 4, 2);
        arg0.version = 4;
    }

    public fun admin_pause<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.paused = true;
        0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::events::emit_paused();
    }

    public fun admin_remove_feed<T0>(arg0: &mut MarketRegistry<T0>, arg1: 0x1::string::String, arg2: &0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::config::has_feed(&arg0.id, &arg1), 28);
        0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::config::remove_feed(&mut arg0.id, arg1);
        0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::events::emit_feed_removed(arg1);
    }

    public fun admin_sweep_unclaimed<T0>(arg0: &mut MarketRegistry<T0>, arg1: &mut 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::Market<T0>, arg2: &0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::admin::AdminCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::resolved<T0>(arg1) || 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::voided<T0>(arg1), 19);
        let v0 = if (0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::voided<T0>(arg1)) {
            let v1 = 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::deadline<T0>(arg1);
            let v2 = 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::voided_at<T0>(arg1);
            if (v2 > v1) {
                v2
            } else {
                v1
            }
        } else {
            0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::resolved_at<T0>(arg1)
        };
        assert!(0x2::clock::timestamp_ms(arg3) >= v0 + 2592000000, 23);
        0x2::balance::join<T0>(&mut arg0.treasury, 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::sweep_unclaimed<T0>(arg1));
    }

    public fun admin_unpause<T0>(arg0: &mut MarketRegistry<T0>, arg1: &0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.paused = false;
        0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::events::emit_unpaused();
    }

    public fun admin_update_cutoff<T0>(arg0: &mut MarketRegistry<T0>, arg1: u8, arg2: u64, arg3: &0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::admin::AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 5, 4);
        assert!(arg2 > 0, 29);
        0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::config::set_cutoff(&mut arg0.id, arg1, arg2);
    }

    public fun admin_update_fee<T0>(arg0: &mut MarketRegistry<T0>, arg1: u16, arg2: &0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 5000, 6);
        arg0.fee_bps = arg1;
        0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::events::emit_fee_updated(arg1);
    }

    public fun admin_update_limits<T0>(arg0: &mut MarketRegistry<T0>, arg1: u64, arg2: u64, arg3: &0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::admin::AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg2 >= arg1, 15);
        arg0.min_bet = arg1;
        arg0.max_bet = arg2;
    }

    public fun admin_update_virtual<T0>(arg0: &mut MarketRegistry<T0>, arg1: u8, arg2: u64, arg3: &0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::admin::AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 5, 4);
        assert!(arg2 > 0, 30);
        0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::config::set_virtual(&mut arg0.id, arg1, arg2);
    }

    public fun admin_void<T0>(arg0: &mut 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::Market<T0>, arg1: &0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::admin::AdminCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::void<T0>(arg0, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun admin_withdraw_treasury<T0>(arg0: &mut MarketRegistry<T0>, arg1: u64, arg2: &0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 15);
        assert!(0x2::balance::value<T0>(&arg0.treasury) >= arg1, 18);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.treasury, arg1), arg3)
    }

    fun assert_not_paused<T0>(arg0: &MarketRegistry<T0>) {
        assert!(!arg0.paused, 0);
    }

    fun assert_version<T0>(arg0: &MarketRegistry<T0>) {
        assert!(arg0.version == 4, 1);
    }

    public fun buy_shares<T0>(arg0: &mut 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::Market<T0>, arg1: &MarketRegistry<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        assert_not_paused<T0>(arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg1.min_bet, 13);
        assert!(v0 <= arg1.max_bet, 14);
        0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::buy<T0>(arg0, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5), arg6);
    }

    public fun create_market<T0>(arg0: &mut MarketRegistry<T0>, arg1: 0x1::string::String, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: &0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::admin::AdminCap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_not_paused<T0>(arg0);
        assert!(arg3 < 5, 4);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg7), 5);
        assert!(arg5 > 0, 30);
        assert!(0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::config::has_feed(&arg0.id, &arg1), 3);
        arg0.market_count = arg0.market_count + 1;
        0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::share<T0>(0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::new<T0>(arg0.market_count, arg1, *0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::config::get_feed(&arg0.id, &arg1), arg2, arg3, arg4, arg4 - 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::config::get_cutoff(&arg0.id, arg3), arg5, arg0.fee_bps, 0x2::clock::timestamp_ms(arg7), arg8));
    }

    public fun create_registry<T0>(arg0: &0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketRegistry<T0>{
            id           : 0x2::object::new(arg1),
            admin        : 0x2::tx_context::sender(arg1),
            treasury     : 0x2::balance::zero<T0>(),
            market_count : 0,
            fee_bps      : 500,
            paused       : false,
            min_bet      : 1000000,
            max_bet      : 50000000,
            version      : 4,
        };
        0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::config::init_cutoffs(&mut v0.id);
        0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::config::init_virtuals(&mut v0.id);
        0x2::transfer::share_object<MarketRegistry<T0>>(v0);
    }

    public fun fee_bps<T0>(arg0: &MarketRegistry<T0>) : u16 {
        arg0.fee_bps
    }

    public fun market_count<T0>(arg0: &MarketRegistry<T0>) : u64 {
        arg0.market_count
    }

    public fun max_bet<T0>(arg0: &MarketRegistry<T0>) : u64 {
        arg0.max_bet
    }

    public fun min_bet<T0>(arg0: &MarketRegistry<T0>) : u64 {
        arg0.min_bet
    }

    public fun paused<T0>(arg0: &MarketRegistry<T0>) : bool {
        arg0.paused
    }

    public fun redeem<T0>(arg0: &mut 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::Market<T0>, arg1: &MarketRegistry<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg1);
        0x2::coin::from_balance<T0>(0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::redeem_payout<T0>(arg0, arg2), arg2)
    }

    public fun refund<T0>(arg0: &mut 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::Market<T0>, arg1: &MarketRegistry<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg1);
        0x2::coin::from_balance<T0>(0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::refund_payout<T0>(arg0, arg2), arg2)
    }

    public fun resolve<T0>(arg0: &mut 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::Market<T0>, arg1: &MarketRegistry<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        assert_not_paused<T0>(arg1);
        0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::resolve_market<T0>(arg0, 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::price::read_price(arg2, 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::pyth_feed_id<T0>(arg0), 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::deadline<T0>(arg0), 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::duration<T0>(arg0)), 0x2::tx_context::sender(arg4), 0x2::clock::timestamp_ms(arg3));
    }

    public fun sell_shares<T0>(arg0: &mut 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::Market<T0>, arg1: &MarketRegistry<T0>, arg2: u8, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg1);
        0x2::coin::from_balance<T0>(0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::market::sell<T0>(arg0, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5), arg6), arg6)
    }

    public fun treasury_value<T0>(arg0: &MarketRegistry<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.treasury)
    }

    public fun version<T0>(arg0: &MarketRegistry<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

