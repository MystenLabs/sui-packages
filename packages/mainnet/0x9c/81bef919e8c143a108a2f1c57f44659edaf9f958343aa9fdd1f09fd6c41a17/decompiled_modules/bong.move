module 0x9c81bef919e8c143a108a2f1c57f44659edaf9f958343aa9fdd1f09fd6c41a17::bong {
    struct BONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONG>(arg0, 6, b"Bong", b"Bangbangbong", b"100% Bitcoin-backed, Meme it, HODL it, love it! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bangbangbong_db1c6783cf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

