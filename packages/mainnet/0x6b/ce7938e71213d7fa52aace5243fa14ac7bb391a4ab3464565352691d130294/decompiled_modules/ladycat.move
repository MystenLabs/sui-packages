module 0x6bce7938e71213d7fa52aace5243fa14ac7bb391a4ab3464565352691d130294::ladycat {
    struct LADYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LADYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LADYCAT>(arg0, 6, b"LADYCAT", b"LADYCAT SUI", b"Mem tocen on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/323232_7a29f7666a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LADYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LADYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

