module 0xc99a420c3916ac974225d2eea587f979b2d565bbf00af2553b638a3a33c54764::gooch {
    struct GOOCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOCH>(arg0, 6, b"GOOCH", b"Gooch", b"The SWAG ROACH on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MGA_LOGO_SOL_5_56ef647b43.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

