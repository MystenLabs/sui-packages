module 0x8003fa19df9a60837c8edb706976c6d13ebfb709e52a1e7c86d890a520596a1c::pinky {
    struct PINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKY>(arg0, 9, b"PINKY", b"Sui Pinky", b"All legendary ideas are born over a beer - $PINKY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmdbEr5HkLMENPwrXidRBXYA4ALQpvg1HMr6wDgXQQWLWG?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PINKY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

