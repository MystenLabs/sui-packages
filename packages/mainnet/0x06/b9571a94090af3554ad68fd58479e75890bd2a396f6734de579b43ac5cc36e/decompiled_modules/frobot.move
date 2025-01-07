module 0x6b9571a94090af3554ad68fd58479e75890bd2a396f6734de579b43ac5cc36e::frobot {
    struct FROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROBOT>(arg0, 6, b"FROBOT", b"Frobot", b"Be the light with the shine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7357506c634fc5f8d21523670c364b8e_40b0bba27b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

