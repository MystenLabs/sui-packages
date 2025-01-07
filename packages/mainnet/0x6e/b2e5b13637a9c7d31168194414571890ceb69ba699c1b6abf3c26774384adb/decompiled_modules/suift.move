module 0x6eb2e5b13637a9c7d31168194414571890ceb69ba699c1b6abf3c26774384adb::suift {
    struct SUIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFT>(arg0, 6, b"SUIFT", b"Taylor Suift", b"SUIFT! https://t.me/suift_taylor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/Q6Ybskp/photo-2024-10-05-14-39-30.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIFT>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

