module 0x21782f0f0a273152e087a417adf447ee9d11c6f5fc4ff43521a2c70b14c27a4d::cda {
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

