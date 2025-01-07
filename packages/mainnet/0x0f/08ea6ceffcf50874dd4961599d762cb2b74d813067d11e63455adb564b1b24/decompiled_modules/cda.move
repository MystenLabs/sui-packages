module 0xf08ea6ceffcf50874dd4961599d762cb2b74d813067d11e63455adb564b1b24::cda {
    struct CDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDA>(arg0, 6, b"CDA", b"CambodiaDigitalAsset", b"A digital asset representing the Cambodian economy, aiming to facilitate secure and transparent transactions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735129292809.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

