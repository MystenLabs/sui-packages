module 0x4635ff4849be024b4136a6e6df3c883055d45abcad9e1b4f829b9ed3de25a1f1::wal {
    struct WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAL>(arg0, 9, b"WAL", b"WAL Token", b"The native token for the Walrus Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.walrus.xyz/wal-icon.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WAL>>(0x2::coin::mint<WAL>(&mut v2, 5000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WAL>>(v2);
    }

    // decompiled from Move bytecode v6
}

