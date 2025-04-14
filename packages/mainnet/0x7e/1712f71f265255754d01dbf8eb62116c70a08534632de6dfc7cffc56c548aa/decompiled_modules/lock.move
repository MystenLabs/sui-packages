module 0x7e1712f71f265255754d01dbf8eb62116c70a08534632de6dfc7cffc56c548aa::lock {
    struct LOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCK>(arg0, 6, b"LOCK", b"Lock", b"Just Lock, When to lock, Lock Lock Lock", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000057667_6fd3f52665.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

