module 0x29665fd43404d83ec72b290b303eee07c851f4673c807f481e5aedf5d05c7a62::billy {
    struct BILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLY>(arg0, 6, b"BILLY", b"Billy", b"https://x.com/billycoinsolana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726644624449_56c5b6ef31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

