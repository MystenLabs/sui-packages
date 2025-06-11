module 0x5477621b2453d95c731fd5f776ec07b7b8cfa39af93d4d0572b109a547cafde3::suichick {
    struct SUICHICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHICK>(arg0, 6, b"SuiChick", b"Chick On Sui", x"535549434849434b200a546865205261696e626f7720436869636b20536f6172696e67204f7665722074686520537569204f6365616e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihigoyoc3rg6byroht2bznyujmqemqu5pwguyyxhry45paem4b33y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICHICK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

