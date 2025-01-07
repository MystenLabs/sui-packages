module 0x4f077ba89959667093b7453d405ed082e18478767e26b57cc1a728a3330a381e::bfdog {
    struct BFDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFDOG>(arg0, 6, b"BFDOG", b"Black Friday DOG", b"Sundays are like Black Friday for memecoins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dfgdfgdfgdfg_501d9151c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BFDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

