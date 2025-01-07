module 0xdb9212a7a0525721b536e7fdc17aa9bf1508cc3481e52ce4f886cc4ae4cf23b4::boge {
    struct BOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOGE>(arg0, 6, b"BOGE", b"BOGE ON SUI", b"$BOGE is a laid-back memecoin on the Sui network, featuring a chill dog mascot enjoying life with style. Built around fun and community, $BOGE aims to be the coolest token in the crypto space!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/boge_hp_1473x1536_b029ac6add.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

