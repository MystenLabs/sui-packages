module 0x46b9fd95d2379a6a9e238166c17ace1e88e77305c1628f17e3a60e9f59229d8f::freep {
    struct FREEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREEP>(arg0, 6, b"FreeP", b"Free Palestine", b"Help us to create a big move to help poeple !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_da_A_cran_2024_10_01_101111_0e9142edf8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

