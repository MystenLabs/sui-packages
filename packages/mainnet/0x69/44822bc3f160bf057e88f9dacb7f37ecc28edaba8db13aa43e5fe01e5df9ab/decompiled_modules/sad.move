module 0x6944822bc3f160bf057e88f9dacb7f37ecc28edaba8db13aa43e5fe01e5df9ab::sad {
    struct SAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAD>(arg0, 6, b"SAD", b"SADMEW", b"sadmeww", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigl5xxap7fphz7ciopnjkw43iiv55f3qv3chadxoiza3ernx4rqlq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

