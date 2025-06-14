module 0x16086ff4ce5947907c8dcfd04c9fa70e28562e13f0317451601c0ed28dd747b2::askjdb {
    struct ASKJDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASKJDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASKJDB>(arg0, 6, b"ASKJDB", b"KJASBDIASGBD", b"AJHADSVHJDAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihrmghaf3rv4hxh6o6qrvrzhjb3wn4mxsvalj2hmzrmzzm4tzt3wy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASKJDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASKJDB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

