module 0xfe7c6810f4875326e22f9585a7d5472a2e0221b580e4cfd08d3a94ab6e8059c1::wartime {
    struct WARTIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARTIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARTIME>(arg0, 6, b"WARTIME", b"Napoleon 3523", b"Emperor of Sui. We'll make The Great Flip happen and there is nothing they can do. Join the Sui Imperial Army or perish, it's $WARTIME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731789411170.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARTIME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARTIME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

