module 0xb1ebe0e415a82961f3d979f4faad267edd48246fd4d83d043427b04c7367ebeb::moondog {
    struct MOONDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONDOG>(arg0, 6, b"MOONDOG", b"MoondogOnSui", b"$MOONDOG on sui - the cosmic canine of meme season, Born to bark, built to moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreickla2d7llxrp44g3go7cv72qakyksmsnz7kbonc224i7yfusp2da")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOONDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

