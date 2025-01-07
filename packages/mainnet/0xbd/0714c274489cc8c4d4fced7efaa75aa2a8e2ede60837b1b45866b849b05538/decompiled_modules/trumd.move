module 0xbd0714c274489cc8c4d4fced7efaa75aa2a8e2ede60837b1b45866b849b05538::trumd {
    struct TRUMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMD>(arg0, 6, b"TRUMD", b"Trumpy McDonald", b"Trumpy McDonald on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_21_17_00_53_11582a6993.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

