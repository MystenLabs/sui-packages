module 0x8b702b0834d7573e6a65a0e4aabeddc4b666c798bab853ea3ca0a114ba1b2931::mlg {
    struct MLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLG>(arg0, 6, b"MLG", b"Major League Gaming", b"Created for the Gamers. MlG is on SUI! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736478547692.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MLG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

