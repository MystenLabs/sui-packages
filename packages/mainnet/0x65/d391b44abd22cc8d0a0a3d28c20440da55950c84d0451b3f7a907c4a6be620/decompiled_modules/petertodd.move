module 0x65d391b44abd22cc8d0a0a3d28c20440da55950c84d0451b3f7a907c4a6be620::petertodd {
    struct PETERTODD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PETERTODD>, arg1: 0x2::coin::Coin<PETERTODD>) {
        0x2::coin::burn<PETERTODD>(arg0, arg1);
    }

    fun init(arg0: PETERTODD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETERTODD>(arg0, 9, b"PETERTODD", b"Satoshi Nakamoto", b"Satoshi Nakamoto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNn5C2Si9DBncprwgrbdaLD448tAmDpVk7iZeVVyP5VCr")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PETERTODD>(&mut v2, 6000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PETERTODD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETERTODD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

