module 0x6bd579dddf0984d1a58f8bfd7e69a51660a5b1dea3bcc944d390d7d059a5f5df::bbs {
    struct BBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBS>(arg0, 6, b"BBS", b"BAKEDblu", x"536f6d657468696e6720626f72726f7765642c20736f6d657468696e6720626c752c205448432067756d6d79206265617273206275696c7420626c752e200a41206e657720616476656e747572652061776169747320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9758_6cd3275885.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

