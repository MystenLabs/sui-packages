module 0xa53d3a05be6acd21335ba6fadd2b336fc6eed0202d1ccb234d714e64d220be48::akitaonsui {
    struct AKITAONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKITAONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKITAONSUI>(arg0, 6, b"AKITAonSUI", b"AKITA on SUI", x"414b495441206f6e20535549202d205468652063757465737420646f67206f6e205355492e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gbzi0we_Ww_AM_2_CLD_f9c70e4b3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKITAONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKITAONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

