module 0xe125daf987313bd17cd8a9d7cd7f1bc1117a92851227a678792376f6efd84772::saaskumar {
    struct SAASKUMAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAASKUMAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAASKUMAR>(arg0, 6, b"SAASKUMAR", b"saas", b"i am sasssso", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/transit_review_1096e3882c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAASKUMAR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAASKUMAR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

