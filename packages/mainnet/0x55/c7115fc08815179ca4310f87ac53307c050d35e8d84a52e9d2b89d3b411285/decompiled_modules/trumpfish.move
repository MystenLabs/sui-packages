module 0x55c7115fc08815179ca4310f87ac53307c050d35e8d84a52e9d2b89d3b411285::trumpfish {
    struct TRUMPFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPFISH>(arg0, 6, b"TRUMPFISH", b"trumpfish", x"4d414b45205355492046554e20414741494e0a545255452043544f2050524f4a454354", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/16514296_15_C0_4520_96_F9_217_E4552799_C_08b05981b1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

