module 0x20319cc7cccb66e096eefed7087b89605524ec00f0450da87c5802effff2c02::dbtb {
    struct DBTB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBTB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBTB>(arg0, 6, b"DBTB", b"DONT BUY TEST TRADE BOT", b"JUST TESTING MY TRADE BOT DONT BUY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GHOST_AI_01_de5e4c2754.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBTB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBTB>>(v1);
    }

    // decompiled from Move bytecode v6
}

