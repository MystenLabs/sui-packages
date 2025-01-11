module 0x9c77915d2a6bd8b2c5496d517b8843afe979301b297254f240771879718a1e6d::secondvictory {
    struct SECONDVICTORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SECONDVICTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SECONDVICTORY>(arg0, 6, b"SecondVictory", b"Second Victory", b"https://2ndvictory.xyz/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3b580e212080391_672e6e29d3f2d_6896b449f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SECONDVICTORY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SECONDVICTORY>>(v1);
    }

    // decompiled from Move bytecode v6
}

