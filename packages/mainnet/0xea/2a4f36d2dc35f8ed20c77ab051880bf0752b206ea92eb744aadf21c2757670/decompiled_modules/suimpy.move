module 0xea2a4f36d2dc35f8ed20c77ab051880bf0752b206ea92eb744aadf21c2757670::suimpy {
    struct SUIMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMPY>(arg0, 6, b"SUIMPY", b"Suimpy", x"4d656574205355494d50590a5468652043757465737420536872696d7020546f6b656e206f6e20535549204e6574776f726b0a4a6f696e2074686520756e646572776174657220616476656e747572652077697468205355494d50592c20746865206d6f73742061646f7261626c65206d656d6520746f6b656e20696e207468652063727970746f206f6365616e2e204f7572206c6974746c6520626c756520736872696d7020697320726561647920746f206d616b652062696720776176657320696e20746865205355492065636f73797374656d21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimp_logo_92f525d4ae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

