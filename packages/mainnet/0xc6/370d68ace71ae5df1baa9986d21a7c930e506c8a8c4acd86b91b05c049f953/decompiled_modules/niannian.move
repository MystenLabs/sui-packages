module 0xc6370d68ace71ae5df1baa9986d21a7c930e506c8a8c4acd86b91b05c049f953::niannian {
    struct NIANNIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIANNIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIANNIAN>(arg0, 6, b"NIANNIAN", b"NianNian Academy", x"41206e6577206d656d65636f696e206b696e672069732061626f757420746f2062652063726f776e65640a202020200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hdnzcx_ee125e12e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIANNIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIANNIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

