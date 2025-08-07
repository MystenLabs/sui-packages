module 0x8aa20382ca85e43a1baad9c414cbdd0b43a4dbfe68efca6be17e49b339baca25::ao1 {
    struct AO1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AO1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AO1>(arg0, 6, b"AO1", b"AO1 Functions", x"4130312069732074686520696e74656c6c6967656e63652068756220666f72206d656d65636f696e73206f6e205355492e0a4275696c7420666f7220747261646572732c20627920747261646572732c206f757220706c6174666f726d2070726f76696465732063757474696e672d656467652041492d64726976656e20696e7369676874732c207265616c2074696d6520747261636b696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaukqayengdeklsclwq6uzsaiti2y3bdfig3btmh27qw6z7imrptq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AO1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AO1>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

