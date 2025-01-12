module 0xb6ddb0d7ae16ef33c330530f5ab0fcf92223db02847ae9668626cd958d559ba3::zenai {
    struct ZENAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZENAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ZENAI>(arg0, 6, b"ZENAI", b"ZENAI by SuiAI", b"ZENAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_18_a7ba0a1b91.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZENAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZENAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

