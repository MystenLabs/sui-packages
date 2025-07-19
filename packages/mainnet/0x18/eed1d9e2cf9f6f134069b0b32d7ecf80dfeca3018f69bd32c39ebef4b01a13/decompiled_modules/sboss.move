module 0x18eed1d9e2cf9f6f134069b0b32d7ecf80dfeca3018f69bd32c39ebef4b01a13::sboss {
    struct SBOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOSS>(arg0, 6, b"SBOSS", b"Sui Boss", x"53554920424f53532069736ee2809974206a7573742061206d656d6520636f696e20e28093206974e28099732061206d6f76656d656e742e20506f77657265642062792074686520737065656420616e64207365637572697479206f66207468652053756920626c6f636b636861696e2c2024424f53532072697365732061732074686520666561726c657373206c6561646572206f662061206e6577206469676974616c2064796e617374792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752947545154.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBOSS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOSS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

