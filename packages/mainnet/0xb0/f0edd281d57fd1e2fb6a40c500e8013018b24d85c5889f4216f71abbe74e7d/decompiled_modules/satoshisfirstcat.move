module 0xb0f0edd281d57fd1e2fb6a40c500e8013018b24d85c5889f4216f71abbe74e7d::satoshisfirstcat {
    struct SATOSHISFIRSTCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSHISFIRSTCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSHISFIRSTCAT>(arg0, 6, b"Satoshisfirstcat", b"POMO", b"https://panoptishard.livejournal.com/2007/04/11/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013915_b7e5c7370f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHISFIRSTCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOSHISFIRSTCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

