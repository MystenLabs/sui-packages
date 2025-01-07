module 0x21c741eeef7a5cf8c9590275d43490b78bca47e86688b58041c852b1174bc5ce::bpepe {
    struct BPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPEPE>(arg0, 6, b"BPEPE", b"BLUE PEPE", b"everything is blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015062_694554a36a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

