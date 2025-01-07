module 0x943fab9df355573935cf3e619583ec835c16350858fd746abed83de37dc1bde8::js_coin {
    struct MintEvent has copy, drop {
        symbol: vector<u8>,
        mint_amount: u64,
        total_supply: u64,
    }

    struct BurnEvent has copy, drop {
        symbol: vector<u8>,
        burn_amount: u64,
        total_supply: u64,
    }

    struct JS_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JS_COIN>, arg1: 0x2::coin::Coin<JS_COIN>) {
        let v0 = BurnEvent{
            symbol       : b"JSC",
            burn_amount  : 0x2::coin::value<JS_COIN>(&arg1),
            total_supply : get_total_supply(arg0),
        };
        0x2::event::emit<BurnEvent>(v0);
        0x2::coin::burn<JS_COIN>(arg0, arg1);
    }

    fun get_total_supply(arg0: &0x2::coin::TreasuryCap<JS_COIN>) : u64 {
        0x2::balance::supply_value<JS_COIN>(0x2::coin::supply_immut<JS_COIN>(arg0))
    }

    fun init(arg0: JS_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JS_COIN>(arg0, 2, b"JSC", b"JS Coin", b"coin for JS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/964008?v=4&size=64")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JS_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JS_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JS_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MintEvent{
            symbol       : b"JSC",
            mint_amount  : arg1,
            total_supply : get_total_supply(arg0),
        };
        0x2::event::emit<MintEvent>(v0);
        0x2::coin::mint_and_transfer<JS_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

