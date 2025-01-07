module 0xc4cc83fd960d2a960e08fcd4b95a30a8320754b4091355dcf0bfeac47c7f5c74::joey {
    struct JOEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOEY>(arg0, 9, b"Joey", b"Joey The Koala", x"4a6f657920746865206b6f616c6120697320612074696e792c2061646f7261626c652062616279206b6f616c612077686f207370656e6473206d6f7374206f6620686973206561726c79206d6f6e74687320736e7567676c656420696e20686973206d6f74686572e280997320706f756368", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://hitriracun.si/prenosioblak/Joey_the_koala_250x250")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JOEY>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

