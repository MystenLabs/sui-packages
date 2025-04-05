module 0xb7767f9ca0aebc31b3b80733173a015f9c831a1510ae7dc93f2e240d5988fbe1::mob {
    struct MOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOB>(arg0, 6, b"MOB", b"MOBFI", b"DO NOT BUY JUST ADS NO CABAL SO ADS! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bossring1_71c928584f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

