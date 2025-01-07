module 0x6f75b35ea93ae8e3cb3444577e01e094846c758c98f8cd8d23e1fb208fa20ae1::wizard {
    struct WIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIZARD>(arg0, 6, b"WIZARD", b"Wizard on Suichain", b"Chillin Wizard on Suichain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wizard_351432b829.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

