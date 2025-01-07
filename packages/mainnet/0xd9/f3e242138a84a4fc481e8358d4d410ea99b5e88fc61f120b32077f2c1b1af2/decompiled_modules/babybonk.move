module 0xd9f3e242138a84a4fc481e8358d4d410ea99b5e88fc61f120b32077f2c1b1af2::babybonk {
    struct BABYBONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYBONK>(arg0, 6, b"BabyBonk", b"Baby bonk", x"544845204241425920444f4720434f494e204f46205448452050454f504c450a0a4241425920424f4e4b2e204c455453204255494c44204f4e205355492e204c4647", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/baby_bonk_720b92852f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYBONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYBONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

