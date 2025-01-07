module 0xddbaff70e7a1cb099383d17ff92008dd12c3e1af7979c382696f42c78a24c3e9::sig {
    struct SIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIG>(arg0, 6, b"SIG", b"SIG GAY COIN", b"SIG is a trademark, an identity. he rocks hairstyles as he's gonna rock the SUI ecosystem with da power of memetics. SIG can be whoever he wants: the bald, the testosterone hairy, but SIG always chooses being a winner.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suispiciously_3d9e660f1c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

