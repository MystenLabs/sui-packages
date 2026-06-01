module 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal {
    struct WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAL>(arg0, 9, b"WAL", b"MemWalPP WAL", b"Placeholder WAL for MemWal++ marketplace tests", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

