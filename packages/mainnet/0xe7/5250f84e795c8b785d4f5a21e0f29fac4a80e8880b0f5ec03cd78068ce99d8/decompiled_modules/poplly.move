module 0xe75250f84e795c8b785d4f5a21e0f29fac4a80e8880b0f5ec03cd78068ce99d8::poplly {
    struct POPLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPLLY>(arg0, 6, b"Poplly", b"POPLLY", b"Join the $POPLLY community NOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_00_23_56_4fc13cb6fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

