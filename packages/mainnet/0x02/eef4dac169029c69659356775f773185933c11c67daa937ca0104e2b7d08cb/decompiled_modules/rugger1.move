module 0x2eef4dac169029c69659356775f773185933c11c67daa937ca0104e2b7d08cb::rugger1 {
    struct RUGGER1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGGER1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGGER1>(arg0, 6, b"RUGGER1", b"DONTBUY RUG", b"ad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qzt29qc2mehd78y8ooa7ot2odxou_2bcc7b11a8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGGER1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGGER1>>(v1);
    }

    // decompiled from Move bytecode v6
}

