module 0x25052c59b91435f542112ea3e03eef804fec150bc7ed3182682996c70315fd4a::wiseguy {
    struct WISEGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WISEGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WISEGUY>(arg0, 6, b"WiseGuy", b"CryptoFellas", x"546865206d61666961206f66206d656d6520636f696e732c206275696c74206f6e206c6f79616c747920616e6420687573746c652e20457870616e64696e6720746f2053554920666f72206c696768746e696e672d66617374207472616e73616374696f6e7320616e64206c696d69746c6573732067726f7774682e200a0a4a6f696e207468652066616d696c792c20776865726520616d626974696f6e206d6565747320696e6e6f766174696f6e2c20616e6420746f676574686572207765e280996c6c20646f6d696e6174652074686520626c6f636b636861696e20737472656574732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733108007736.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WISEGUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WISEGUY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

