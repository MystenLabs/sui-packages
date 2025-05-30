module 0xf39c917525019886ff7e260f1a580af0f0cd1d6b51572c90389f8d42e5815a8a::walrus {
    struct WALRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALRUS>(arg0, 9, b"WAL", b"WAL Token", b"The native token for the Walrus Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.walrus.xyz/wal-icon.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALRUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WALRUS>>(0x2::coin::mint<WALRUS>(&mut v2, 5000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WALRUS>>(v2);
    }

    // decompiled from Move bytecode v6
}

