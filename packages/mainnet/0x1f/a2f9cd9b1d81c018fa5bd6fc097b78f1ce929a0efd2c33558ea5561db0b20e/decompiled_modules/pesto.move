module 0x1fa2f9cd9b1d81c018fa5bd6fc097b78f1ce929a0efd2c33558ea5561db0b20e::pesto {
    struct PESTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESTO>(arg0, 2, b"PESTO", b"King Pesto", b"King Pesto - King of the Sui | @KingoftheSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PESTO>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESTO>>(v2, @0x4b9d2430e7686446ddebecb0f7277fea61b9e7288aaf575166ea07fb51502e03);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PESTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

