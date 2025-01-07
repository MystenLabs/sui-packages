module 0xa234ebb9f713364326b11642f3b99a25877f410bbd7ea26b167b75a2c24528f8::pluff {
    struct PLUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUFF>(arg0, 6, b"Pluff", b"PLUFFish", b"Pluffopluffo they yell like sound suiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241011_201304_5bf7f082dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

