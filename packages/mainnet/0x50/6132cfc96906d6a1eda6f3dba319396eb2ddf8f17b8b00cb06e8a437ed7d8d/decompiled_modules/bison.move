module 0x506132cfc96906d6a1eda6f3dba319396eb2ddf8f17b8b00cb06e8a437ed7d8d::bison {
    struct BISON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BISON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BISON>(arg0, 9, b"BISON", b"BISON ON SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNc98gnjA3SBZXDEjzjKwRMgjk5x48CEHvkjZCUbvvSFX")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BISON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BISON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BISON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

