module 0x78a67611b23dcb2351070b40a38eed027ed01954f131e338d25a430f3ff3ac07::brian {
    struct BRIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRIAN>(arg0, 6, b"Brian", b"Brian Sui", b"$BRIAN LIVES! In loving memory of $BRIAN. \"More than a dog, a best friend\".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_58e11677d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

