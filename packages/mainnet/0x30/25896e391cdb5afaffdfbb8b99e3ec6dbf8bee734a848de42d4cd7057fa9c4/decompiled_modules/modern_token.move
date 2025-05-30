module 0x3025896e391cdb5afaffdfbb8b99e3ec6dbf8bee734a848de42d4cd7057fa9c4::modern_token {
    struct MODERN_TOKEN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TokenConfig has store, key {
        id: 0x2::object::UID,
        max_supply: u64,
        current_supply: u64,
    }

    struct TokenMinted has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct TokenBurned has copy, drop {
        amount: u64,
        sender: address,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MODERN_TOKEN>, arg1: &mut TokenConfig, arg2: 0x2::coin::Coin<MODERN_TOKEN>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<MODERN_TOKEN>(&arg2);
        arg1.current_supply = arg1.current_supply - v0;
        let v1 = TokenBurned{
            amount : v0,
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TokenBurned>(v1);
        0x2::coin::burn<MODERN_TOKEN>(arg0, arg2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MODERN_TOKEN>, arg1: &mut TokenConfig, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.current_supply + arg2 <= arg1.max_supply, 2);
        arg1.current_supply = arg1.current_supply + arg2;
        let v0 = TokenMinted{
            amount    : arg2,
            recipient : arg3,
        };
        0x2::event::emit<TokenMinted>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<MODERN_TOKEN>>(0x2::coin::mint<MODERN_TOKEN>(arg0, arg2, arg4), arg3);
    }

    public fun get_supply(arg0: &TokenConfig) : (u64, u64) {
        (arg0.max_supply, arg0.current_supply)
    }

    fun init(arg0: MODERN_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MODERN_TOKEN>(arg0, 9, b"MINI", b"MiniMe", b"MiniMe - The First MiniMe Meme Token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaKr41gXz7tBXWTJtnyPisRADbSy9oELVsvs35x7UgATe")), arg1);
        let v2 = v0;
        let v3 = 1000000000000000000;
        let v4 = TokenConfig{
            id             : 0x2::object::new(arg1),
            max_supply     : v3,
            current_supply : v3,
        };
        let v5 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::coin::Coin<MODERN_TOKEN>>(0x2::coin::mint<MODERN_TOKEN>(&mut v2, v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MODERN_TOKEN>>(v1);
        0x2::transfer::public_share_object<TokenConfig>(v4);
        0x2::transfer::transfer<AdminCap>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MODERN_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

