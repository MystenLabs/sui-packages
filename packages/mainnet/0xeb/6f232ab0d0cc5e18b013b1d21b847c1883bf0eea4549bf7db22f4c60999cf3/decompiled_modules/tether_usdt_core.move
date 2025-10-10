module 0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core {
    struct TETHER_USDT_CORE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TokenConfig has key {
        id: 0x2::object::UID,
        paused: bool,
        admin: address,
        total_minted: u64,
        total_burned: u64,
    }

    struct MintEvent has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
        sender: address,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TETHER_USDT_CORE>, arg1: &mut TokenConfig, arg2: 0x2::coin::Coin<TETHER_USDT_CORE>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 1001);
        let v0 = 0x2::coin::value<TETHER_USDT_CORE>(&arg2);
        assert!(v0 > 0, 1004);
        0x2::coin::burn<TETHER_USDT_CORE>(arg0, arg2);
        arg1.total_burned = arg1.total_burned + v0;
        let v1 = BurnEvent{
            amount : v0,
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<BurnEvent>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TETHER_USDT_CORE>, arg1: &mut TokenConfig, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 1001);
        assert!(arg2 > 0, 1004);
        assert!(0x2::tx_context::sender(arg4) == arg1.admin, 1003);
        arg1.total_minted = arg1.total_minted + arg2;
        let v0 = MintEvent{
            recipient : arg3,
            amount    : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<TETHER_USDT_CORE>>(0x2::coin::mint<TETHER_USDT_CORE>(arg0, arg2, arg4), arg3);
    }

    fun init(arg0: TETHER_USDT_CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETHER_USDT_CORE>(arg0, 6, b"USDT", b"Tether USD (Stability Enhanced)", b"Tether USD stablecoin with collateral backing and peg maintenance on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/825.png")), arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = TokenConfig{
            id           : 0x2::object::new(arg1),
            paused       : false,
            admin        : 0x2::tx_context::sender(arg1),
            total_minted : 0,
            total_burned : 0,
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TETHER_USDT_CORE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETHER_USDT_CORE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<TokenConfig>(v3);
    }

    public fun is_paused(arg0: &TokenConfig) : bool {
        arg0.paused
    }

    public fun total_supply(arg0: &TokenConfig) : u64 {
        arg0.total_minted - arg0.total_burned
    }

    // decompiled from Move bytecode v6
}

