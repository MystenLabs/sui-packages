module 0xada96d4bbb82c781d0a850debd077260a76498521432625eea808cfccde283fb::mrwitchcat {
    struct MRWITCHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRWITCHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRWITCHCAT>(arg0, 6, b"MRWITCHCAT", b"Mr Witchcat", b"Mr Witchcat came to have fun on Halloween ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030905_83b567a1a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRWITCHCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRWITCHCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

