module 0x53bfc87eb27b5dc19111e9d80c543e8d79057d23d7de6bf4042d2b67a45faa41::peal {
    struct PEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEAL>(arg0, 6, b"PEAL", b"PEAL THE SEAL", x"4d656574205065616c20746865205365616c2c2074686520636f6f6c657374206d6173636f74206f6e207468652053756920626c6f636b636861696e210a0a5765726520616c6c2061626f757420676f6f642076696265732c2066756e206d656d65732c20616e64206d616b696e6720245045414c20736f6d657468696e67207370656369616c2e204665656c206672656520746f206a756d7020696e2c2061736b207175657374696f6e732c206f72206a7573742068616e67206f75742e20476c616420746f206861766520796f75207769746820757321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/abe_a8cadd6c7d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

