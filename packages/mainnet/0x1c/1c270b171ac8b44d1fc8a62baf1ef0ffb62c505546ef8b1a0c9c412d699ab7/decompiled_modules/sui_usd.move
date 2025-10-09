module 0x1c1c270b171ac8b44d1fc8a62baf1ef0ffb62c505546ef8b1a0c9c412d699ab7::sui_usd {
    struct SUI_USD has drop {
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

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUI_USD>, arg1: &mut TokenConfig, arg2: 0x2::coin::Coin<SUI_USD>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 1001);
        let v0 = 0x2::coin::value<SUI_USD>(&arg2);
        assert!(v0 > 0, 1004);
        0x2::coin::burn<SUI_USD>(arg0, arg2);
        arg1.total_burned = arg1.total_burned + v0;
        let v1 = BurnEvent{
            amount : v0,
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<BurnEvent>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI_USD>, arg1: &mut TokenConfig, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 1001);
        assert!(arg2 > 0, 1004);
        assert!(0x2::tx_context::sender(arg4) == arg1.admin, 1003);
        arg1.total_minted = arg1.total_minted + arg2;
        let v0 = MintEvent{
            recipient : arg3,
            amount    : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI_USD>>(0x2::coin::mint<SUI_USD>(arg0, arg2, arg4), arg3);
    }

    fun init(arg0: SUI_USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_USD>(arg0, 6, b"SUSD", b"Sui USD", b"USD stablecoin on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/usd-coin-usdc-logo.png")), arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = TokenConfig{
            id           : 0x2::object::new(arg1),
            paused       : false,
            admin        : 0x2::tx_context::sender(arg1),
            total_minted : 0,
            total_burned : 0,
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_USD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_USD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<TokenConfig>(v3);
    }

    public fun is_paused(arg0: &TokenConfig) : bool {
        arg0.paused
    }

    public entry fun pause(arg0: &AdminCap, arg1: &mut TokenConfig, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.paused = true;
    }

    public fun total_supply(arg0: &TokenConfig) : u64 {
        arg0.total_minted - arg0.total_burned
    }

    public entry fun unpause(arg0: &AdminCap, arg1: &mut TokenConfig, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.paused = false;
    }

    // decompiled from Move bytecode v6
}

