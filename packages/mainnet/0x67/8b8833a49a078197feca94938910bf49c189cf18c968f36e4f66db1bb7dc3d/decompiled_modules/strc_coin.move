module 0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc_coin {
    struct STRC_COIN has drop {
        dummy_field: bool,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<STRC_COIN>,
        deny_cap: 0x2::coin::DenyCapV2<STRC_COIN>,
        registry: 0x1::option::Option<0x2::object::ID>,
        auth: 0x1::option::Option<0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::WrapAuth>,
        wrapped_shares: u64,
        paused_since_ms: u64,
        exit_mode: bool,
        exit_until_ms: u64,
    }

    struct Wrapped has copy, drop {
        shares: u64,
        by: address,
    }

    struct Unwrapped has copy, drop {
        shares: u64,
        by: address,
    }

    struct PauseSynced has copy, drop {
        paused: bool,
    }

    struct ExitWindowOpened has copy, drop {
        paused_since_ms: u64,
        opened_ms: u64,
        closes_ms: u64,
    }

    struct ExitWindowClosed has copy, drop {
        closed_ms: u64,
    }

    public fun total_supply(arg0: &Vault) : u64 {
        0x2::coin::total_supply<STRC_COIN>(&arg0.treasury)
    }

    public fun bind(arg0: &mut Vault, arg1: &mut 0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::Registry, arg2: &0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::AdminCap) {
        assert!(0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::admin_cap_registry(arg2) == 0x2::object::id<0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::Registry>(arg1), 101);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.registry), 102);
        arg0.registry = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::Registry>(arg1));
        0x1::option::fill<0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::WrapAuth>(&mut arg0.auth, 0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::issue_wrap_auth(arg1, arg2));
    }

    fun check(arg0: &Vault, arg1: &0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::Registry) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.registry), 103);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.registry) == 0x2::object::id<0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::Registry>(arg1), 101);
    }

    public fun exit_mode(arg0: &Vault) : bool {
        arg0.exit_mode
    }

    public fun exit_until_ms(arg0: &Vault) : u64 {
        arg0.exit_until_ms
    }

    fun init(arg0: STRC_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<STRC_COIN>(arg0, 6, b"STRC", b"STRC", b"STRC. Backed by Treasury-owned STRC (xStocks STRCx); not personal funds. Backing self-reported by Sajan, held in a Treasury wallet. Keys to the Treasury wallet are held by Sajan on his own device or hardware wallet; owned by the Treasury and the Bene Gesserit through the DAO with golden-ratio balancing. Supply is capped at Sajan's own on-chain attested share count. Not endorsed by or affiliated with Strategy; not issued or endorsed by xStocks. Not redeemable in v1. Pays no dividends. Burning releases no underlying.", 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRC_COIN>>(v2);
        let v3 = Vault{
            id              : 0x2::object::new(arg1),
            treasury        : v0,
            deny_cap        : v1,
            registry        : 0x1::option::none<0x2::object::ID>(),
            auth            : 0x1::option::none<0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::WrapAuth>(),
            wrapped_shares  : 0,
            paused_since_ms : 0,
            exit_mode       : false,
            exit_until_ms   : 0,
        };
        0x2::transfer::share_object<Vault>(v3);
    }

    public fun is_paused_next_epoch(arg0: &0x2::deny_list::DenyList) : bool {
        0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<STRC_COIN>(arg0)
    }

    public fun open_exit_window(arg0: &mut Vault, arg1: &0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::Registry, arg2: &mut 0x2::deny_list::DenyList, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check(arg0, arg1);
        assert!(0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::is_stale(arg1, arg3) || !0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::is_backed(arg1), 104);
        assert!(arg0.paused_since_ms > 0 && !arg0.exit_mode, 104);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.paused_since_ms + 259200000, 105);
        if (0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<STRC_COIN>(arg2)) {
            0x2::coin::deny_list_v2_disable_global_pause<STRC_COIN>(arg2, &mut arg0.deny_cap, arg4);
        };
        arg0.exit_mode = true;
        arg0.exit_until_ms = 0x2::clock::timestamp_ms(arg3) + 259200000;
        let v0 = ExitWindowOpened{
            paused_since_ms : arg0.paused_since_ms,
            opened_ms       : 0x2::clock::timestamp_ms(arg3),
            closes_ms       : arg0.exit_until_ms,
        };
        0x2::event::emit<ExitWindowOpened>(v0);
    }

    public fun rate(arg0: &0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::Registry) : u64 {
        0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::multiplier(arg0)
    }

    public fun redeem_request(arg0: &mut Vault, arg1: &mut 0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::Registry, arg2: 0x2::coin::Coin<STRC_COIN>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check(arg0, arg1);
        let v0 = 0x2::coin::burn<STRC_COIN>(&mut arg0.treasury, arg2);
        arg0.wrapped_shares = arg0.wrapped_shares - v0;
        0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::queue_redeem_wrapped(arg1, 0x1::option::borrow<0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::WrapAuth>(&arg0.auth), 0x2::tx_context::sender(arg4), v0, arg3);
    }

    public fun symbol() : vector<u8> {
        b"STRC"
    }

    public fun sync_pause(arg0: &mut Vault, arg1: &0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::Registry, arg2: &mut 0x2::deny_list::DenyList, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check(arg0, arg1);
        let v0 = if (0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::is_stale(arg1, arg3)) {
            true
        } else if (!0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::is_backed(arg1)) {
            true
        } else {
            0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::is_halted(arg1)
        };
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = if (v0) {
            if (arg0.exit_mode) {
                v1 >= arg0.exit_until_ms
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            arg0.exit_mode = false;
            arg0.exit_until_ms = 0;
            let v3 = ExitWindowClosed{closed_ms: v1};
            0x2::event::emit<ExitWindowClosed>(v3);
        };
        if (v0) {
            if (!arg0.exit_mode && !0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<STRC_COIN>(arg2)) {
                0x2::coin::deny_list_v2_enable_global_pause<STRC_COIN>(arg2, &mut arg0.deny_cap, arg4);
                arg0.paused_since_ms = 0x2::clock::timestamp_ms(arg3);
            };
        } else {
            if (0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<STRC_COIN>(arg2)) {
                0x2::coin::deny_list_v2_disable_global_pause<STRC_COIN>(arg2, &mut arg0.deny_cap, arg4);
            };
            arg0.paused_since_ms = 0;
            arg0.exit_mode = false;
            arg0.exit_until_ms = 0;
        };
        let v4 = v0 && !arg0.exit_mode;
        let v5 = PauseSynced{paused: v4};
        0x2::event::emit<PauseSynced>(v5);
    }

    public fun unwrap(arg0: &mut Vault, arg1: &0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::Registry, arg2: 0x2::coin::Coin<STRC_COIN>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::Balance {
        check(arg0, arg1);
        let v0 = 0x2::coin::burn<STRC_COIN>(&mut arg0.treasury, arg2);
        arg0.wrapped_shares = arg0.wrapped_shares - v0;
        let v1 = Unwrapped{
            shares : v0,
            by     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Unwrapped>(v1);
        0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::release_from_wrap(arg1, 0x1::option::borrow<0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::WrapAuth>(&arg0.auth), v0, arg3, arg4)
    }

    public fun value_of(arg0: &0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::Registry, arg1: u64) : u64 {
        0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::to_display(arg0, arg1)
    }

    public fun wrap(arg0: &mut Vault, arg1: &0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::Registry, arg2: 0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::Balance, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<STRC_COIN> {
        check(arg0, arg1);
        let v0 = 0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::lock_for_wrap(arg1, 0x1::option::borrow<0x678b8833a49a078197feca94938910bf49c189cf18c968f36e4f66db1bb7dc3d::strc::WrapAuth>(&arg0.auth), arg2, arg3);
        arg0.wrapped_shares = arg0.wrapped_shares + v0;
        let v1 = Wrapped{
            shares : v0,
            by     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Wrapped>(v1);
        0x2::coin::mint<STRC_COIN>(&mut arg0.treasury, v0, arg4)
    }

    public fun wrapped_shares(arg0: &Vault) : u64 {
        arg0.wrapped_shares
    }

    // decompiled from Move bytecode v7
}

