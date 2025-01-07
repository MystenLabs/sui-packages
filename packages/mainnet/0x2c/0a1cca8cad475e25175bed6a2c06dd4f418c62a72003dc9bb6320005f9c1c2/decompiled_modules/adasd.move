module 0x2c0a1cca8cad475e25175bed6a2c06dd4f418c62a72003dc9bb6320005f9c1c2::adasd {
    struct ADASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADASD>(arg0, 6, b"ADASD", b"zxczxc", b"ggasdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_a0cfdda928.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADASD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADASD>>(v1);
    }

    // decompiled from Move bytecode v6
}

