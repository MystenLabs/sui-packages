module 0x5762416ee65d54e132a79dbff68c1febfb67667876dca37212495783e1907a77::suicharm {
    struct SUICHARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHARM>(arg0, 6, b"SUICHARM", b"SUICHARMANDER", b"CharmSui is a fire-charged cryptocurrency on the SUI blockchain, sparking innovation and electrifying the crypto world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000196882_c0d0fe8310.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

