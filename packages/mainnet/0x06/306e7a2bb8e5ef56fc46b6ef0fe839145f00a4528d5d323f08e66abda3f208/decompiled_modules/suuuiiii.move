module 0x6306e7a2bb8e5ef56fc46b6ef0fe839145f00a4528d5d323f08e66abda3f208::suuuiiii {
    struct SUUUIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUUUIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUUUIIII>(arg0, 6, b"SUUUIIII", b"Suuiiii", b"Suuuuuuiiiiiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1032_47099e13be.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUUUIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUUUIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

