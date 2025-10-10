module 0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::peg_maintenance_bot {
    struct PegMaintenanceBot has key {
        id: 0x2::object::UID,
        usdt_reserves: 0x2::balance::Balance<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>,
        sui_reserves: 0x2::balance::Balance<0x2::sui::SUI>,
        target_price: u64,
        price_tolerance: u64,
        max_trade_size: u64,
        total_buys: u64,
        total_sells: u64,
        total_volume: u64,
        admin: address,
        active: bool,
    }

    struct PriceData has copy, drop, store {
        price: u64,
        timestamp: u64,
        confidence: u64,
    }

    struct TradingStats has copy, drop {
        action: vector<u8>,
        amount: u64,
        price_before: u64,
        price_after: u64,
        timestamp: u64,
    }

    public entry fun auto_rebalance(arg0: &mut PegMaintenanceBot, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 3001);
        let v0 = if (arg1 > arg0.target_price) {
            arg1 - arg0.target_price
        } else {
            arg0.target_price - arg1
        };
        if (v0 > arg0.price_tolerance) {
            let v1 = v0 * 1000;
            if (arg1 > arg0.target_price) {
                if (0x2::balance::value<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(&arg0.usdt_reserves) >= v1) {
                    sell_usdt_for_peg(arg0, arg1, v1, arg2);
                };
            } else if (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserves) >= v1 * arg1 / 10000) {
                buy_usdt_for_peg(arg0, arg1, v1, arg2);
            };
        };
    }

    public entry fun buy_usdt_for_peg(arg0: &mut PegMaintenanceBot, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 3001);
        assert!(arg1 < arg0.target_price - arg0.price_tolerance, 3003);
        assert!(arg2 <= arg0.max_trade_size, 3005);
        let v0 = arg2 * arg1 / 10000;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserves) >= v0, 3002);
        arg0.total_buys = arg0.total_buys + 1;
        arg0.total_volume = arg0.total_volume + arg2;
        let v1 = TradingStats{
            action       : b"buy",
            amount       : arg2,
            price_before : arg1,
            price_after  : arg1 + 50,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TradingStats>(v1);
        0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserves, v0));
    }

    public entry fun fund_bot(arg0: &mut PegMaintenanceBot, arg1: 0x2::coin::Coin<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 3004);
        0x2::balance::join<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(&mut arg0.usdt_reserves, 0x2::coin::into_balance<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(arg1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserves, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun get_bot_stats(arg0: &PegMaintenanceBot) : (u64, u64, u64, u64, u64) {
        (0x2::balance::value<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(&arg0.usdt_reserves), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserves), arg0.total_buys, arg0.total_sells, arg0.total_volume)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PegMaintenanceBot{
            id              : 0x2::object::new(arg0),
            usdt_reserves   : 0x2::balance::zero<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(),
            sui_reserves    : 0x2::balance::zero<0x2::sui::SUI>(),
            target_price    : 10000,
            price_tolerance : 100,
            max_trade_size  : 100000,
            total_buys      : 0,
            total_sells     : 0,
            total_volume    : 0,
            admin           : 0x2::tx_context::sender(arg0),
            active          : true,
        };
        0x2::transfer::share_object<PegMaintenanceBot>(v0);
    }

    public entry fun mint_at_dollar(arg0: &mut PegMaintenanceBot, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 3001);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(0x2::balance::value<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(&arg0.usdt_reserves) >= v0, 3002);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserves, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>>(0x2::coin::from_balance<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(0x2::balance::split<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(&mut arg0.usdt_reserves, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun needs_rebalancing(arg0: &PegMaintenanceBot, arg1: u64) : bool {
        let v0 = if (arg1 > arg0.target_price) {
            arg1 - arg0.target_price
        } else {
            arg0.target_price - arg1
        };
        v0 > arg0.price_tolerance
    }

    public entry fun redeem_at_dollar(arg0: &mut PegMaintenanceBot, arg1: 0x2::coin::Coin<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 3001);
        let v0 = 0x2::coin::value<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(&arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserves) >= v0, 3002);
        0x2::balance::join<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(&mut arg0.usdt_reserves, 0x2::coin::into_balance<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserves, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun sell_usdt_for_peg(arg0: &mut PegMaintenanceBot, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 3001);
        assert!(arg1 > arg0.target_price + arg0.price_tolerance, 3003);
        assert!(arg2 <= arg0.max_trade_size, 3005);
        assert!(0x2::balance::value<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(&arg0.usdt_reserves) >= arg2, 3002);
        arg0.total_sells = arg0.total_sells + 1;
        arg0.total_volume = arg0.total_volume + arg2;
        let v0 = TradingStats{
            action       : b"sell",
            amount       : arg2,
            price_before : arg1,
            price_after  : arg1 - 50,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TradingStats>(v0);
        0x2::balance::destroy_zero<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(0x2::balance::split<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(&mut arg0.usdt_reserves, arg2));
    }

    public entry fun set_bot_status(arg0: &mut PegMaintenanceBot, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3004);
        arg0.active = arg1;
    }

    public entry fun update_parameters(arg0: &mut PegMaintenanceBot, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 3004);
        arg0.price_tolerance = arg1;
        arg0.max_trade_size = arg2;
    }

    // decompiled from Move bytecode v6
}

