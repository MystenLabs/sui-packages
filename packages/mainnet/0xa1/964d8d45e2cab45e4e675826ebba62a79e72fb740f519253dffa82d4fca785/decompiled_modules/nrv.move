module 0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv {
    struct NRV has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TokenConfig has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<NRV>,
        trading_enabled: bool,
        paused: bool,
        trading_enabled_at_ms: u64,
        total_burned: u64,
        cooldown_ms: u64,
        lp_reserve: address,
        blacklist: 0x2::table::Table<address, bool>,
        exempt: 0x2::table::Table<address, bool>,
        last_transfer: 0x2::table::Table<address, u64>,
    }

    struct TokensBurned has copy, drop {
        amount: u64,
        total_burned: u64,
        initiator: address,
    }

    struct TransferExecuted has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
        burned: u64,
    }

    struct FeeCollected has copy, drop {
        sender: address,
        fee_amount: u64,
        fee_pool: address,
    }

    struct LpFeeCollected has copy, drop {
        sender: address,
        lp_burned: u64,
        lp_reserved: u64,
        lp_reserve: address,
    }

    struct TradingEnabled has copy, drop {
        enabled_at_ms: u64,
        admin: address,
    }

    struct AddressBlacklisted has copy, drop {
        target: address,
        blacklisted: bool,
    }

    struct CooldownUpdated has copy, drop {
        old_ms: u64,
        new_ms: u64,
        admin: address,
    }

    public fun mint(arg0: &AdminCap, arg1: &mut TokenConfig, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NRV>>(0x2::coin::mint<NRV>(&mut arg1.treasury, arg2, arg4), arg3);
    }

    fun apply_lp_fee(arg0: &mut 0x2::coin::Coin<NRV>, arg1: u64, arg2: &mut TokenConfig, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg1 * 200 / 10000;
        if (v0 == 0) {
            return 0
        };
        let v1 = v0 / 2;
        let v2 = v0 - v1;
        if (v1 > 0) {
            arg2.total_burned = arg2.total_burned + v1;
            0x2::coin::burn<NRV>(&mut arg2.treasury, 0x2::coin::split<NRV>(arg0, v1, arg3));
            let v3 = TokensBurned{
                amount       : v1,
                total_burned : arg2.total_burned,
                initiator    : 0x2::tx_context::sender(arg3),
            };
            0x2::event::emit<TokensBurned>(v3);
        };
        let v4 = arg2.lp_reserve;
        if (v2 > 0) {
            let v5 = LpFeeCollected{
                sender      : 0x2::tx_context::sender(arg3),
                lp_burned   : v1,
                lp_reserved : v2,
                lp_reserve  : v4,
            };
            0x2::event::emit<LpFeeCollected>(v5);
            0x2::transfer::public_transfer<0x2::coin::Coin<NRV>>(0x2::coin::split<NRV>(arg0, v2, arg3), v4);
        };
        v0
    }

    public fun buyback_burn(arg0: 0x2::coin::Coin<NRV>, arg1: &mut TokenConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<NRV>(&arg0);
        assert!(v0 > 0, 2);
        arg1.total_burned = arg1.total_burned + v0;
        let v1 = TokensBurned{
            amount       : v0,
            total_burned : arg1.total_burned,
            initiator    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<TokensBurned>(v1);
        0x2::coin::burn<NRV>(&mut arg1.treasury, arg0);
    }

    fun check_and_update_limits(arg0: address, arg1: u64, arg2: u64, arg3: &mut TokenConfig) {
        let v0 = if (arg2 < arg3.trading_enabled_at_ms + 300000) {
            100000000000000000 / 10000
        } else {
            100000000000000000 * 100 / 10000
        };
        assert!(arg1 <= v0, 5);
        if (0x2::table::contains<address, u64>(&arg3.last_transfer, arg0)) {
            assert!(arg2 >= *0x2::table::borrow<address, u64>(&arg3.last_transfer, arg0) + arg3.cooldown_ms, 7);
            *0x2::table::borrow_mut<address, u64>(&mut arg3.last_transfer, arg0) = arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg3.last_transfer, arg0, arg2);
        };
    }

    public fun cooldown_ms(arg0: &TokenConfig) : u64 {
        arg0.cooldown_ms
    }

    public fun enable_trading(arg0: &AdminCap, arg1: &mut TokenConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.trading_enabled, 10);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg1.trading_enabled = true;
        arg1.trading_enabled_at_ms = v0;
        let v1 = TradingEnabled{
            enabled_at_ms : v0,
            admin         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TradingEnabled>(v1);
    }

    fun init(arg0: NRV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NRV>(arg0, 9, b"NRV", b"NRV Network", b"NRV Network DePin AI Token - Guru Training Rewards", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        let v3 = TokenConfig{
            id                    : 0x2::object::new(arg1),
            treasury              : v0,
            trading_enabled       : false,
            paused                : false,
            trading_enabled_at_ms : 0,
            total_burned          : 0,
            cooldown_ms           : 5000,
            lp_reserve            : v2,
            blacklist             : 0x2::table::new<address, bool>(arg1),
            exempt                : 0x2::table::new<address, bool>(arg1),
            last_transfer         : 0x2::table::new<address, u64>(arg1),
        };
        0x2::table::add<address, bool>(&mut v3.exempt, v2, true);
        0x2::transfer::share_object<TokenConfig>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NRV>>(v1);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v4, v2);
    }

    public fun is_blacklisted(arg0: &TokenConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.blacklist, arg1)
    }

    public fun is_exempt(arg0: &TokenConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.exempt, arg1)
    }

    public fun is_paused(arg0: &TokenConfig) : bool {
        arg0.paused
    }

    public fun is_trading_enabled(arg0: &TokenConfig) : bool {
        arg0.trading_enabled
    }

    public fun lp_reserve(arg0: &TokenConfig) : address {
        arg0.lp_reserve
    }

    public fun set_blacklist(arg0: &AdminCap, arg1: &mut TokenConfig, arg2: address, arg3: bool) {
        if (arg3) {
            if (!0x2::table::contains<address, bool>(&arg1.blacklist, arg2)) {
                0x2::table::add<address, bool>(&mut arg1.blacklist, arg2, true);
            };
        } else if (0x2::table::contains<address, bool>(&arg1.blacklist, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.blacklist, arg2);
        };
        let v0 = AddressBlacklisted{
            target      : arg2,
            blacklisted : arg3,
        };
        0x2::event::emit<AddressBlacklisted>(v0);
    }

    public fun set_exempt(arg0: &AdminCap, arg1: &mut TokenConfig, arg2: address, arg3: bool) {
        if (arg3) {
            if (!0x2::table::contains<address, bool>(&arg1.exempt, arg2)) {
                0x2::table::add<address, bool>(&mut arg1.exempt, arg2, true);
            };
        } else if (0x2::table::contains<address, bool>(&arg1.exempt, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.exempt, arg2);
        };
    }

    public fun set_lp_reserve(arg0: &AdminCap, arg1: &mut TokenConfig, arg2: address) {
        arg1.lp_reserve = arg2;
    }

    public fun set_pause(arg0: &AdminCap, arg1: &mut TokenConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun total_burned(arg0: &TokenConfig) : u64 {
        arg0.total_burned
    }

    public fun transfer_v2(arg0: 0x2::coin::Coin<NRV>, arg1: u64, arg2: address, arg3: address, arg4: &mut TokenConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!arg4.paused, 9);
        assert!(arg1 > 0, 2);
        assert!(0x2::coin::value<NRV>(&arg0) >= arg1, 3);
        let v1 = 0x2::table::contains<address, bool>(&arg4.exempt, v0);
        let v2 = 0x2::table::contains<address, bool>(&arg4.exempt, arg2);
        assert!(arg4.trading_enabled || v1, 4);
        assert!(!0x2::table::contains<address, bool>(&arg4.blacklist, v0), 8);
        assert!(!0x2::table::contains<address, bool>(&arg4.blacklist, arg2), 8);
        if (!v1) {
            check_and_update_limits(v0, arg1, 0x2::clock::timestamp_ms(arg5), arg4);
        };
        let v3 = v1 && v2;
        let v4 = if (v3) {
            0
        } else {
            arg1 * 100 / 10000
        };
        let v5 = if (v3) {
            0
        } else {
            arg1 * 100 / 10000
        };
        if (v4 > 0) {
            arg4.total_burned = arg4.total_burned + v4;
            0x2::coin::burn<NRV>(&mut arg4.treasury, 0x2::coin::split<NRV>(&mut arg0, v4, arg6));
            let v6 = TokensBurned{
                amount       : v4,
                total_burned : arg4.total_burned,
                initiator    : v0,
            };
            0x2::event::emit<TokensBurned>(v6);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<NRV>>(0x2::coin::split<NRV>(&mut arg0, v5, arg6), arg3);
            let v7 = FeeCollected{
                sender     : v0,
                fee_amount : v5,
                fee_pool   : arg3,
            };
            0x2::event::emit<FeeCollected>(v7);
        };
        let v8 = if (v3) {
            0
        } else {
            let v9 = &mut arg0;
            apply_lp_fee(v9, arg1, arg4, arg6)
        };
        let v10 = TransferExecuted{
            sender    : v0,
            recipient : arg2,
            amount    : arg1,
            burned    : v4,
        };
        0x2::event::emit<TransferExecuted>(v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<NRV>>(0x2::coin::split<NRV>(&mut arg0, arg1 - v4 - v5 - v8, arg6), arg2);
        if (0x2::coin::value<NRV>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<NRV>>(arg0, v0);
        } else {
            0x2::coin::destroy_zero<NRV>(arg0);
        };
    }

    public fun transfer_with_burn(arg0: 0x2::coin::Coin<NRV>, arg1: u64, arg2: address, arg3: &mut TokenConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!arg3.paused, 9);
        assert!(arg1 > 0, 2);
        assert!(0x2::coin::value<NRV>(&arg0) >= arg1, 3);
        let v1 = 0x2::table::contains<address, bool>(&arg3.exempt, v0);
        let v2 = 0x2::table::contains<address, bool>(&arg3.exempt, arg2);
        assert!(arg3.trading_enabled || v1, 4);
        assert!(!0x2::table::contains<address, bool>(&arg3.blacklist, v0), 8);
        assert!(!0x2::table::contains<address, bool>(&arg3.blacklist, arg2), 8);
        if (!v1) {
            check_and_update_limits(v0, arg1, 0x2::clock::timestamp_ms(arg4), arg3);
        };
        let v3 = v1 && v2;
        let v4 = if (v3) {
            0
        } else {
            arg1 * 100 / 10000
        };
        if (v4 > 0) {
            arg3.total_burned = arg3.total_burned + v4;
            0x2::coin::burn<NRV>(&mut arg3.treasury, 0x2::coin::split<NRV>(&mut arg0, v4, arg5));
            let v5 = TokensBurned{
                amount       : v4,
                total_burned : arg3.total_burned,
                initiator    : v0,
            };
            0x2::event::emit<TokensBurned>(v5);
        };
        let v6 = if (v3) {
            0
        } else {
            let v7 = &mut arg0;
            apply_lp_fee(v7, arg1, arg3, arg5)
        };
        let v8 = TransferExecuted{
            sender    : v0,
            recipient : arg2,
            amount    : arg1,
            burned    : v4,
        };
        0x2::event::emit<TransferExecuted>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<NRV>>(0x2::coin::split<NRV>(&mut arg0, arg1 - v4 - v6, arg5), arg2);
        if (0x2::coin::value<NRV>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<NRV>>(arg0, v0);
        } else {
            0x2::coin::destroy_zero<NRV>(arg0);
        };
    }

    public fun update_cooldown(arg0: &AdminCap, arg1: &mut TokenConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.cooldown_ms = arg2;
        let v0 = CooldownUpdated{
            old_ms : arg1.cooldown_ms,
            new_ms : arg2,
            admin  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CooldownUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

