module 0xe481847d41695ab8009482ea7fc5d0bcfe63df043c8d79ed88ea36a5644a2f61::adasdas {
    struct ADASDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADASDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADASDAS>(arg0, 6, b"Adasdas", b"POKeqweqwe", b"asdasdsa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidfbxlv5xbacxn3zxdlwiymr7lhlwdzcfjbcdiodktz5hqac7lasm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADASDAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADASDAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

