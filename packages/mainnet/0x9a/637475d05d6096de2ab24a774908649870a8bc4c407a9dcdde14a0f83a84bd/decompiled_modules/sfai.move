module 0x9a637475d05d6096de2ab24a774908649870a8bc4c407a9dcdde14a0f83a84bd::sfai {
    struct SFAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFAI>(arg0, 6, b"SFAI", b"SupportFI AI", b"SupportFi AI is a Customer Support as a Service (CSaaS) platform that enables businesses to deliver exceptional support through multiple communication channels.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_255f061554.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

