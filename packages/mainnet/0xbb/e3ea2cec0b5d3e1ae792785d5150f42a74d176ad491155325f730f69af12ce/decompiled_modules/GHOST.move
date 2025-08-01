module 0xbbe3ea2cec0b5d3e1ae792785d5150f42a74d176ad491155325f730f69af12ce::GHOST {
    struct GHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOST>(arg0, 6, b"GhostCoin", b"GHOST", x"412073706f6f6b792c20756e747261636561626c65206d656d6520636f696e20666f722074686f73652077686f206c6f766520616e6f6e796d69747920616e64206d656d65732e2047686f7374436f696e2069732074686520756c74696d61746520746f6b656e20666f722074686520736861646f7773e280946e6f207472616365732c206a757374206c617567687320616e6420646563656e7472616c697a65642076696265732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/IOq6emC48xyfr0QToADeNn0WPswzPeN9TdMSef5ev6OwniSjKA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOST>>(v0, @0x65d0417fd33d9b42cc917b3277898d7bf8c739379146854128cda304d5f3afdc);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

