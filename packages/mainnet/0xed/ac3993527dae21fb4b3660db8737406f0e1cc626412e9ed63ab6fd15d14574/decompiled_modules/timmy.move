module 0xedac3993527dae21fb4b3660db8737406f0e1cc626412e9ed63ab6fd15d14574::timmy {
    struct TIMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIMMY>(arg0, 6, b"TIMMY", b"WISHING TIMMY", b"$TIMMY, the incredible crypto token inspired by the beloved cartoon character, Timmy Turner from \"The Fairly OddParents\"! With $TIMMY, we bring the magic of the animated world into the realm of digital investments.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/timylogo_90caaac0b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

