module 0xa52498d17de301d32ad41f49b014217d03d7b7490fbdc7f1c8a308368d415f31::lipa {
    struct LIPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIPA>(arg0, 6, b"Lipa", b"lipa", x"4d656d6520626f742068747470733a2f2f742e6d652f42756c6c7842657461426f743f73746172743d6163636573735f32575a4d434246523141470a576562332047616d696e672f2f4e46542f486f7374202342696e616e6365200a436f6e74656e74202620436f6d6d756e697479200a4057616e7a6943727970746f0a5265736561726368200a40546f6b656e6d6f72650a202f2f4d6f6e69204c6f766572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12221_2c09ff5b80.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

