module 0x75996cbea3629f5fbef41db92299ceeaf04dd98b203a49c64a996ba72fd8267b::magnet6900 {
    struct MAGNET6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGNET6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGNET6900>(arg0, 6, b"MAGNET6900", b"MAGNET 6900", x"4d61676e65746963204d6f7665732c204c6567656e646172792052657475726e73212024363930300a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3754_5647e18b45.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGNET6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGNET6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

