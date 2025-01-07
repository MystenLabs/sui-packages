module 0xd668e5feb3a117f6a978452e5c06f74aa53d7d53ba7c9d2838c89dd462a65d41::tet {
    struct TET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TET>(arg0, 6, b"TET", b"TEST", b"TESTTEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1750_0ce2ba07d5.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TET>>(v1);
    }

    // decompiled from Move bytecode v6
}

