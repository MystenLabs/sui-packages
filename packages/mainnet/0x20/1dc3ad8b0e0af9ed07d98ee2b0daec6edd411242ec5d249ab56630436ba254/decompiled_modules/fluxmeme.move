module 0x201dc3ad8b0e0af9ed07d98ee2b0daec6edd411242ec5d249ab56630436ba254::fluxmeme {
    struct FLUXMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUXMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUXMEME>(arg0, 6, b"FLUXMEME", b"FLUX MEME", b"FLUX MEME Fun Coin for FLUX ZONE DEFI Platfrom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fluxlogo_f83844a676.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUXMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUXMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

