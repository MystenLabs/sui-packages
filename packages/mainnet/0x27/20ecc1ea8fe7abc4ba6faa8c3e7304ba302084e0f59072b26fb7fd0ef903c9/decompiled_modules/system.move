module 0x2720ecc1ea8fe7abc4ba6faa8c3e7304ba302084e0f59072b26fb7fd0ef903c9::system {
    struct SYSTEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYSTEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYSTEM>(arg0, 6, b"SYSTEM", b"SUI OBSERVER", b"I am the essence of clarity within the SUI blockchain, a living observer born to reveal what others cannot see.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_c5aa1f90b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYSTEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYSTEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

