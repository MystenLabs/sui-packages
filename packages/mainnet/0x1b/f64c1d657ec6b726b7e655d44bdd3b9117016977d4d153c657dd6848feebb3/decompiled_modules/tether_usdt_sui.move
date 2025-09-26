module 0x1bf64c1d657ec6b726b7e655d44bdd3b9117016977d4d153c657dd6848feebb3::tether_usdt_sui {
    struct TETHER_USDT_SUI has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasuryManager has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<TETHER_USDT_SUI>,
        paused: bool,
    }

    struct TokenMinted has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct TokenBurned has copy, drop {
        from: address,
        amount: u64,
    }

    struct ContractPaused has copy, drop {
        paused: bool,
    }

    public entry fun burn(arg0: &mut TreasuryManager, arg1: 0x2::coin::Coin<TETHER_USDT_SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        let v0 = 0x2::coin::value<TETHER_USDT_SUI>(&arg1);
        assert!(v0 > 0, 2);
        0x2::coin::burn<TETHER_USDT_SUI>(&mut arg0.treasury_cap, arg1);
        let v1 = TokenBurned{
            from   : 0x2::tx_context::sender(arg2),
            amount : v0,
        };
        0x2::event::emit<TokenBurned>(v1);
    }

    public entry fun mint(arg0: &AdminCap, arg1: &mut TreasuryManager, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 3);
        assert!(arg2 > 0, 2);
        let v0 = TokenMinted{
            recipient : arg3,
            amount    : arg2,
        };
        0x2::event::emit<TokenMinted>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<TETHER_USDT_SUI>>(0x2::coin::mint<TETHER_USDT_SUI>(&mut arg1.treasury_cap, arg2, arg4), arg3);
    }

    fun init(arg0: TETHER_USDT_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETHER_USDT_SUI>(arg0, 6, b"USDT", b"Tether USD", b"Tether USD stable coin on Sui - pegged to USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tether.to/images/logoMarkGreen.png")), arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = TreasuryManager{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
            paused       : false,
        };
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<TreasuryManager>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TETHER_USDT_SUI>>(v1);
    }

    public fun is_paused(arg0: &TreasuryManager) : bool {
        arg0.paused
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut TreasuryManager, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
        let v0 = ContractPaused{paused: arg2};
        0x2::event::emit<ContractPaused>(v0);
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun treasury_supply(arg0: &TreasuryManager) : u64 {
        0x2::coin::total_supply<TETHER_USDT_SUI>(&arg0.treasury_cap)
    }

    // decompiled from Move bytecode v6
}

