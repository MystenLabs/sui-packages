module 0x78a0678c2f88f86731064c7f70266d1d6510d0fdfacd69d14d52b926a66a42c7::sspx6900 {
    struct SSPX6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSPX6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSPX6900>(arg0, 6, b"SSPX6900", b"SUI6900", b" why not MURAD ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_13_at_12_15_33_6e60ae0dff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSPX6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSPX6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

