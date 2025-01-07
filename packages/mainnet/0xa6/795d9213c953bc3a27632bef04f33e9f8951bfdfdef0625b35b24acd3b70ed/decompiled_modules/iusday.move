module 0xa6795d9213c953bc3a27632bef04f33e9f8951bfdfdef0625b35b24acd3b70ed::iusday {
    struct IUSDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUSDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUSDAY>(arg0, 6, b"IUSDAY", b"LOST SUI", b"mirrors the narative token of sui that is run by the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/458079976_1481095545875972_1164279931871181120_n_9fcd561f90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUSDAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IUSDAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

