module 0x5a9fa3637b4679b8362a2acbb3e0a2485262ca5b2a80b17ccde06c27d0f7bb04::splat {
    struct SPLAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLAT>(arg0, 9, b"SPLAT", b"Ask Splat", b"Your AI trading companion - Smarter, Faster, Unbiased.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/ca13e3994a3c947855f782b5b39fd2eaa8b0f7b927b124cffbba787049a4c320")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPLAT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLAT>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPLAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

