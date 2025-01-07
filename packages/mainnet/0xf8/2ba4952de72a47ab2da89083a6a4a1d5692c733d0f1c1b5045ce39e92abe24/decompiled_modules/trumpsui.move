module 0xf82ba4952de72a47ab2da89083a6a4a1d5692c733d0f1c1b5045ce39e92abe24::trumpsui {
    struct TRUMPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPSUI>(arg0, 6, b"TrumpSUI", b"Trump on SUI", b"We need the orange man with the blue hair on SUI network! \"MAKE SUI GREAT\" will be the slogan for this year", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d26f81d0_cd19_4844_baa0_ebdb19f1dc36_e126d9ec91.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

