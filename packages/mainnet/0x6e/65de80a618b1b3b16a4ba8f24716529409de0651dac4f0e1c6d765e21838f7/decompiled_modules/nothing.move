module 0x6e65de80a618b1b3b16a4ba8f24716529409de0651dac4f0e1c6d765e21838f7::nothing {
    struct NOTHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTHING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTHING>(arg0, 6, b"NOTHING", b"nothingness", b"no x no tg just a blackscreen website", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dazkw_acaad22239.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTHING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTHING>>(v1);
    }

    // decompiled from Move bytecode v6
}

