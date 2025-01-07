module 0x53ce296ed06118b15489a2a6500571b0398dbaf2941f3076964edb513fe88bf3::kitcat {
    struct KITCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITCAT>(arg0, 6, b"KITCAT", b"Sui Kitcat", b"kitcat was the first transparent masked cat, and we disguised ourselves in circles", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042903_71fbb052de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

