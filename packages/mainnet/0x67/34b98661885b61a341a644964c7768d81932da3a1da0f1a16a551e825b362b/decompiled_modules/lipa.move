module 0x6734b98661885b61a341a644964c7768d81932da3a1da0f1a16a551e825b362b::lipa {
    struct LIPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIPA>(arg0, 6, b"Lipa", b"lipa Happy birthday", x"4d656d6520626f742068747470733a2f2f742e6d652f42756c6c7842657461426f743f73746172743d6163636573735f32575a4d434246523141470a576562332047616d696e672f2f4e46542f486f7374202342696e616e6365200a436f6e74656e74202620436f6d6d756e697479200a4057616e7a6943727970746f0a200a5265736561726368200a40546f6b656e6d6f72650a202f2f4d6f6e69204c6f766572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12221_a5166f09e8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

