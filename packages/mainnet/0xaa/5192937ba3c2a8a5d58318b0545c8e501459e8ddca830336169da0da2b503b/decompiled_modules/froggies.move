module 0xaa5192937ba3c2a8a5d58318b0545c8e501459e8ddca830336169da0da2b503b::froggies {
    struct FROGGIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGIES>(arg0, 6, b"FROGGIEs", b"FROG OF SUI", b"FROGGIEs THE NEXT PEPE ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_frogies_3710a6b1c7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGGIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

