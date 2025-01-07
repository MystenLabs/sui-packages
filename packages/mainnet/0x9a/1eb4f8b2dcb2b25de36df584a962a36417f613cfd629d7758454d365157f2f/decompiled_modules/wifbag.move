module 0x9a1eb4f8b2dcb2b25de36df584a962a36417f613cfd629d7758454d365157f2f::wifbag {
    struct WIFBAG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WIFBAG>, arg1: 0x2::coin::Coin<WIFBAG>) {
        0x2::coin::burn<WIFBAG>(arg0, arg1);
    }

    fun init(arg0: WIFBAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFBAG>(arg0, 4, b"WIFBAG", b"WIFBAG", b"WIFBAG coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/FF4dN8Qy8NNF88HRgMA3TkbRVZ8PTXWXZCZJb59X3Sbg.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0xaf5e0947b1d00c6f287becc210ab92f471c7cd8bba9f29f107179b535e6d4dd8, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIFBAG>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WIFBAG>>(v2);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<WIFBAG>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WIFBAG>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

