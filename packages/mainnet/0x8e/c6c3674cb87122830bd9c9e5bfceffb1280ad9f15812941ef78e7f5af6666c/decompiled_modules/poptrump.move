module 0x8ec6c3674cb87122830bd9c9e5bfceffb1280ad9f15812941ef78e7f5af6666c::poptrump {
    struct POPTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPTRUMP>(arg0, 6, b"POPTRUMP", b"P0PTRUMP", b"THE PRESIDENT OF THE UNITED STATES! POPTRUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_23_22_01_33_d18eb8bb42.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

