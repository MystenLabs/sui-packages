module 0x2b7e93e081b74e7cad460e02e909146442d9e89eb0dd824b379c949742b2f2dc::aidoge {
    struct AIDOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AIDOGE>, arg1: 0x2::coin::Coin<AIDOGE>) {
        0x2::coin::burn<AIDOGE>(arg0, arg1);
    }

    fun init(arg0: AIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDOGE>(arg0, 2, b"AIDOGE", b"AIDOGE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1683219054885-2bd2f1b7359d4e201cbcccb84ea1b593.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIDOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AIDOGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

