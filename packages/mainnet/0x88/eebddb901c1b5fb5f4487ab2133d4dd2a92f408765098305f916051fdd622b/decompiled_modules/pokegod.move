module 0x88eebddb901c1b5fb5f4487ab2133d4dd2a92f408765098305f916051fdd622b::pokegod {
    struct POKEGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEGOD>(arg0, 6, b"POKEGOD", b"ARCEUS", x"54686520414920506f6bc3a96d6f6e20476f642c2054686520446976696e65204149", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidvq6hsamqegis6vv2qkinhpkp3246btliyjgkz4xmxpaofrzu3om")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEGOD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

