module 0x4679732008795e0517f782331d0fe7d88ce65380e03872ee1fb84ad8feb51bd8::aui {
    struct AUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUI>(arg0, 9, b"AUI", b"audi", x"52657620757020776974682041756469436f696e3a2054686520736c65656b20616e6420706f77657266756c2063727970746f63757272656e6379207468617427732064726976696e6720666173742070726f6669747320616e64206c7578757279206761696e732c2074616b696e6720796f75206f6e206120686967682d6f6374616e65206a6f75726e657920696e207468652063727970746f20776f726c6420f09f9a9720f09f9a9720f09f9a9720f09f9a97", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2ba35f3-fc61-410f-a206-10dfaed2c122.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

