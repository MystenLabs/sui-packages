module 0xeb70ffa19971e169798110a8a0e12fd0f4f003baeb886a9a9ec57281cd5bb63e::broccoli {
    struct BROCCOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROCCOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROCCOLI>(arg0, 9, b"broccoli", b"official cz dog", b"binance wallet will be sent tokens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmP6vQSU5YaBVi1Pe8WqYXNdLGAWp2LHdpzhbL3pcaTPmQ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BROCCOLI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROCCOLI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROCCOLI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

