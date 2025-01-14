module 0xa52929ead4f5a3044d943ab89d71a9e861aa252e86da632266c63533bd9f8171::doku {
    struct DOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOKU>(arg0, 6, b"DOKU", b"DOKUSUI", b"The Purple Schizo Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000144383_9e127729dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

