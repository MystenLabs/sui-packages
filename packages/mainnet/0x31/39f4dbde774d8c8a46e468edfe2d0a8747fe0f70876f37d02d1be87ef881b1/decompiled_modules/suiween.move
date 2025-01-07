module 0x3139f4dbde774d8c8a46e468edfe2d0a8747fe0f70876f37d02d1be87ef881b1::suiween {
    struct SUIWEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWEEN>(arg0, 6, b"SUIWEEN", b"Suiween", b"Suiween ready for moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031423_e82716ac8e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

