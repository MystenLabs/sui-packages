module 0x7291573c5dea9066c42e581751bcd4822aea0f2f64255ebbd2a890032b38be19::sasui {
    struct SASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASUI>(arg0, 6, b"SASUI", b"SARANG ON SUI", x"48692c204974277320534152414e47205355490a0a49276d206120204c6567656e64617279204d454d45", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Launch_now_2_aa45f4d8ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

