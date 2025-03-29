module 0x7a6f2625a4f61360175ab95faa8c497845c1208957e0e7a4fd5c6cc6490d16::pleb {
    struct PLEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLEB>(arg0, 9, b"pleb", b"pleb pleb", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSbJFMnXqsGFmWQ8ABbxhbos6X3MwT9TY886SrEZXiwXx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PLEB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLEB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLEB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

