module 0xd8b2a86d40884e75dcd71c847099e8050399cb0f41bbcdfb3e38ab46aeb90907::punk {
    struct PUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNK>(arg0, 9, b"PUNK", b"THE FROG", b"THE MOST LEGIT CT ACCOUNT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTcEAn6Ty2AoBz4thfMWAWtDHrCKapTbSrxZ2Y6dSpYwz")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUNK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUNK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

