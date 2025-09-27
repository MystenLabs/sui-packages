module 0xbd7695dc192a1008e4ff54494c57ffca136b6f18a3ef0bb05ba47c4f6249e3b5::ondo {
    struct ONDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONDO>(arg0, 2, b"AKURE", b"AKURE ON SUI", b"Sui Akure Workkshop Practical", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/6/61/Federal_University_of_Technology%2C_Akure.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ONDO>>(0x2::coin::mint<ONDO>(&mut v2, 30000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONDO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONDO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

