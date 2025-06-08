module 0xf74399d3f1879fc6fd9bef3df4a5656f9b1d2e10146534e84f2bfeb875bb4aee::swoopdog {
    struct SWOOPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOOPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOOPDOG>(arg0, 6, b"Swoopdog", b"Suinoop Dog", x"53574f4f50444f47202254484520434f4f4c45535420414e442046554e4e49455354204d454d45434f494e204f4e205355492121220a0a233432305649424553", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicw2nblaphejztncpbyuen3yh5vztibz6fqigv7dtjka4berbzaey")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOOPDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SWOOPDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

