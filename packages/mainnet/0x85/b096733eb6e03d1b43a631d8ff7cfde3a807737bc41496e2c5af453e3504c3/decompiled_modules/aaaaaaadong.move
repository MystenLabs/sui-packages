module 0x85b096733eb6e03d1b43a631d8ff7cfde3a807737bc41496e2c5af453e3504c3::aaaaaaadong {
    struct AAAAAAADONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAAADONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAAAADONG>(arg0, 6, b"AAAAAAADONG", b"AAAAAADONGSUI", b"AAAAAAAAAAAAAAAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_185801255_f318e926ee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAAAADONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAAAADONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

