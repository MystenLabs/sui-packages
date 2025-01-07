module 0x2b89947996fc969e9b55e8027fd71bb9f24ed3869fb4c2d8c19a4748cf79a64::goci {
    struct GOCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOCI>(arg0, 6, b"GOCI", b"Goci The Cat", b"Do you keep cats at home? Take care of him so that $GOCI doesn't see, it will be chaotic!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042526_f24661550b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOCI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOCI>>(v1);
    }

    // decompiled from Move bytecode v6
}

