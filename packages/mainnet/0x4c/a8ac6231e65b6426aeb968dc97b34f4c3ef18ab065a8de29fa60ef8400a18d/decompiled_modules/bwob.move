module 0x4ca8ac6231e65b6426aeb968dc97b34f4c3ef18ab065a8de29fa60ef8400a18d::bwob {
    struct BWOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWOB>(arg0, 6, b"BWOB", b"BWOB SUI", b" $BWOB always had trouble belonging because he didnt have a shape of his own. Thats until he realized that he could be whatever he wanted! He could join anyone on any adventure, fill any role! Bwob is for everyone and is now spreading his wisdom and fortune to all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_17_56_48_24ec239fe7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

