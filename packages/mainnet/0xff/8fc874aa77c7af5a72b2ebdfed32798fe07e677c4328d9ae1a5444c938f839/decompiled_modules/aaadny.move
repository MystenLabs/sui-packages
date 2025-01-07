module 0xff8fc874aa77c7af5a72b2ebdfed32798fe07e677c4328d9ae1a5444c938f839::aaadny {
    struct AAADNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADNY>(arg0, 6, b"AAADNY", b"AAAAdeniyi", b"AAAAAAAAAAAAAAAAAAAA Cant stop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_06_23_00_01_b2366210fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

