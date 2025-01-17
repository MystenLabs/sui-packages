module 0x9be5098b5fa659b71660b3bd2aec5c385459b8b7226d48a2f94446d43f552272::randy {
    struct RANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RANDY>(arg0, 6, b"RANDY", b"RandyAI by SuiAI", b"Randy is an open-source, dynamic Artificial Intelligence Automation Platform that runs on your desktop.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2176_cd891078bd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RANDY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RANDY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

