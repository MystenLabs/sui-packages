module 0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta {
    struct VENDETTA has drop {
        dummy_field: bool,
    }

    struct CoinRegistry has store, key {
        id: 0x2::object::UID,
        paused: bool,
        treasury: 0x2::coin::TreasuryCap<VENDETTA>,
    }

    struct VBalance has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<VENDETTA>,
    }

    struct TokenMinted has copy, drop {
        amount: u64,
    }

    struct TokenUnlocked has copy, drop {
        amount: u64,
    }

    struct TokenBurned has copy, drop {
        amount: u64,
    }

    struct MintingToggled has copy, drop {
        paused: bool,
    }

    public fun burn(arg0: &mut CoinRegistry, arg1: 0x2::coin::Coin<VENDETTA>, arg2: &0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta_version::Version) {
        assert!(!arg0.paused, 2);
        0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta_version::validate_version(arg2, 1);
        let v0 = TokenBurned{amount: 0x2::coin::value<VENDETTA>(&arg1)};
        0x2::event::emit<TokenBurned>(v0);
        0x2::coin::burn<VENDETTA>(&mut arg0.treasury, arg1);
    }

    public fun total_supply(arg0: &CoinRegistry) : u64 {
        0x2::coin::total_supply<VENDETTA>(&arg0.treasury)
    }

    fun init(arg0: VENDETTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VENDETTA>(arg0, 9, b"Testing", b"Test", b"Test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VENDETTA>>(v1);
        let v2 = CoinRegistry{
            id       : 0x2::object::new(arg1),
            paused   : true,
            treasury : v0,
        };
        0x2::transfer::share_object<CoinRegistry>(v2);
        let v3 = VBalance{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<VENDETTA>(),
        };
        0x2::transfer::share_object<VBalance>(v3);
    }

    public fun mint_token(arg0: &0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::role::AdminCap, arg1: &mut CoinRegistry, arg2: &mut VBalance, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<VENDETTA>(&arg1.treasury) == 0, 1);
        0x2::balance::join<VENDETTA>(&mut arg2.balance, 0x2::coin::into_balance<VENDETTA>(0x2::coin::mint<VENDETTA>(&mut arg1.treasury, 10000000000000000, arg3)));
        let v0 = TokenMinted{amount: 10000000000000000};
        0x2::event::emit<TokenMinted>(v0);
    }

    public fun toggle_minting(arg0: &0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::role::AdminCap, arg1: &mut CoinRegistry, arg2: &0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta_version::Version) {
        0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta_version::validate_version(arg2, 1);
        arg1.paused = !arg1.paused;
        let v0 = MintingToggled{paused: arg1.paused};
        0x2::event::emit<MintingToggled>(v0);
    }

    public fun unlock_token(arg0: &0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::role::AdminCap, arg1: &mut VBalance, arg2: &CoinRegistry, arg3: u64, arg4: &0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta_version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VENDETTA> {
        assert!(!arg2.paused, 2);
        0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta_version::validate_version(arg4, 1);
        let v0 = TokenUnlocked{amount: arg3};
        0x2::event::emit<TokenUnlocked>(v0);
        0x2::coin::from_balance<VENDETTA>(0x2::balance::split<VENDETTA>(&mut arg1.balance, arg3), arg5)
    }

    // decompiled from Move bytecode v6
}

