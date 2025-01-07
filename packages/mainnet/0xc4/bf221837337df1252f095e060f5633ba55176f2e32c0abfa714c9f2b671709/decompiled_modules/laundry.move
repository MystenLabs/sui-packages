module 0xc4bf221837337df1252f095e060f5633ba55176f2e32c0abfa714c9f2b671709::laundry {
    struct LAUNDRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNDRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAUNDRY>(arg0, 6, b"Laundry", b"Laundry coin", b"Laundry coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028809_ddd30170a7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAUNDRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAUNDRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

