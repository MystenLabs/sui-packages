module 0xe3a79a1e0f5e088945272e584e4cd78206c85f83c37b6555496b2a1a53b7cb42::emriss {
    struct EMRISS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMRISS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMRISS>(arg0, 9, b"PE", b"EMRISS", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMRISS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMRISS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EMRISS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EMRISS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

