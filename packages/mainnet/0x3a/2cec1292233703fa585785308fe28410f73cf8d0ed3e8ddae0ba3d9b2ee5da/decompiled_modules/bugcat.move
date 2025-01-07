module 0x3a2cec1292233703fa585785308fe28410f73cf8d0ed3e8ddae0ba3d9b2ee5da::bugcat {
    struct BUGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUGCAT>(arg0, 6, b"BUGCAT", b"MOVE BUG CAT", b"BUGCAT MOVEPUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3758_dcf2da2878.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

