module 0x31c20d31ca2e6a08038e447a9c77585c3c8e3db55e634ce29de9e312c2fba766::spam {
    struct SPAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAM>(arg0, 6, b"SPAM", b"SPAM SUI", b"Official SPAM SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3601_447be374db.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

