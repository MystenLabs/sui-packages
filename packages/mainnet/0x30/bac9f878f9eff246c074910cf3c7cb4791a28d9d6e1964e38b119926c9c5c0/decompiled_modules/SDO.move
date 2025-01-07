module 0x30bac9f878f9eff246c074910cf3c7cb4791a28d9d6e1964e38b119926c9c5c0::SDO {
    struct SDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDO>(arg0, 8, b"SDO", b"SODUM", b"Sodum is a token that aims to facilitate stuff.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://shdw-drive.genesysgo.net/8za5sLK9jiTdxWaM9nXw7cdzWp2UBPvuFrXzV1EiNike/912.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

