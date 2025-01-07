module 0x9fa24a0f14ae0fcbbd2e61c7cc0267ddc742754a4a8668e9e1ec5b16a86996c6::pofo {
    struct POFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POFO>(arg0, 6, b"POFO", b"pofo", b"weqwelsdoo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B4_B291_BB_6_D28_4591_BABB_5_CFDD_11_EF_206_63e70d7c81.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

