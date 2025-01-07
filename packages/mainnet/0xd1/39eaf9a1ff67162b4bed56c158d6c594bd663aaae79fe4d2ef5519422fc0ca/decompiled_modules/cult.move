module 0xd139eaf9a1ff67162b4bed56c158d6c594bd663aaae79fe4d2ef5519422fc0ca::cult {
    struct CULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULT>(arg0, 6, b"CULT", b"CULT SUI", b"CULT - CULT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_23_27_03_ef58f661cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CULT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CULT>>(v1);
    }

    // decompiled from Move bytecode v6
}

