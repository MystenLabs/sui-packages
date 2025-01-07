module 0xdabea4ba8a7451240ec7e2ff7a05530e3e88036ccfcf12e3cd612871951f83a7::suibidi {
    struct SUIBIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBIDI>(arg0, 6, b"SUIBIDI", b"SUIBIDI Toilet", b"Become a suibidi man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/28_Surprised_Toilet_3587141ed3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

