module 0x9360669ca7af3f246497ba1af89e044dc07d94982255312706371774e70d6cbe::ducky {
    struct DUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKY>(arg0, 6, b"Ducky", b"DuckY on sea", b"Welcome to my boat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_07_24_23_26_27_a63ccfdca1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

