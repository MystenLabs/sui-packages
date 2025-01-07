module 0x92546b1b84dd338cce5bbcac01eda622c905680f34bf08cccbad61fd6a84822f::milton {
    struct MILTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILTON>(arg0, 6, b"MILTON", b"MILTON HURACAN", b"HURACAN MILTON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HURACAN_6f95f81147.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILTON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

