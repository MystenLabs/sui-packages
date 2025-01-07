module 0xff276c7abd4a7a35b08faf1b64353fe0beecca849bf6bc8223730cb98da92b61::ansum {
    struct ANSUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANSUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANSUM>(arg0, 6, b"ANSUM", b"ansum", b"finally found sui twitter i was convinced it didnt exist for the longest time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_0_Xi_WNWUA_At_A5b_5ee1d8890e.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANSUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANSUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

