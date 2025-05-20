module 0xce47d551bb35cbe50480901670029189912c9e02fbbe39361bb4d9f4a0288674::testing {
    struct TESTING has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTING>(arg0, 9, b"TEST", b"testing", b"Sui test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9900/kappa/coins/128e8b3b-ec55-4080-bf2d-10f4e4bac1bb.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

