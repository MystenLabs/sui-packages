module 0xdd7cfa8d7cace032d372217f1c700111b03a566b138f34e4e9f7d0d103f5dc8e::mvst {
    struct MVST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MVST>(arg0, 6, b"MVST", b"Musk vs Trump", b"combination of Musk vs Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Yj_Jy62_WYAAMTHQ_8503d14b2c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MVST>>(v1);
    }

    // decompiled from Move bytecode v6
}

