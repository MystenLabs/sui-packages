module 0xfa1330816cb08a0e4cc434d6a1adaad57a0bd5b55feb80d74422639d91d42371::sbf {
    struct SBF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBF>(arg0, 6, b"SBF", b"SBFL", x"48656c6c6f2065766572796f6e65210a5765206172652053757072656d65204272696c6c69616e792046616d696c792028534246292e0a534246206973206120636f6d6d756e6974792d64726976656e204d656d6520746f6b656e20626f726e206f6e2074686520536f6c616e6120626c6f636b636861696e2c207769746820746865206d697373696f6e3a0ae2809c456e6a6f7920746f6765746865722c207368696e6520746f6765746865722ee2809d0a0a576520617265206e6f74206a7573742061626f75742073706563756c6174696f6e2e0a57652076616c75652067726f77696e67207468652066616d696c792c20686176696e672066756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749529868962.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

