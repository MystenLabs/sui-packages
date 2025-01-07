module 0xe1e39300de3db556a7cb9c0676adb8d5e038e49e4cbdebc8d69f8a44e862514::sooey {
    struct SOOEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOOEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOOEY>(arg0, 6, b"SOOEY", b"SOOEY ON SUI", b"$SOOEY: The Piggy Bank of the Future. First Animal Token on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_02_10_01_38be61819e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOOEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOOEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

