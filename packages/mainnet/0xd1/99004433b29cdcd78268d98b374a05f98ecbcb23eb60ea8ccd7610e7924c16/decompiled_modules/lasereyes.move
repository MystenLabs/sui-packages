module 0xd199004433b29cdcd78268d98b374a05f98ecbcb23eb60ea8ccd7610e7924c16::lasereyes {
    struct LASEREYES has drop {
        dummy_field: bool,
    }

    fun init(arg0: LASEREYES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LASEREYES>(arg0, 6, b"LASEREYES", b"Laser Eyes on Sui", b"Laser eyes project is next 1000x gem. Are you ready for bull season with laser eyes?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241109_185707_744cec92f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LASEREYES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LASEREYES>>(v1);
    }

    // decompiled from Move bytecode v6
}

