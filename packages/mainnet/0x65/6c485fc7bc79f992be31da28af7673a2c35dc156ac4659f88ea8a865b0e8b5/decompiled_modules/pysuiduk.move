module 0x656c485fc7bc79f992be31da28af7673a2c35dc156ac4659f88ea8a865b0e8b5::pysuiduk {
    struct PYSUIDUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYSUIDUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYSUIDUK>(arg0, 6, b"PYSUIDUK", b"PYSUIDUKS", b"Oof, my head hurts!  But hey, thats kinda my thing, right? Im $PSUIDUK, the memecoin thats all about embracing those moments when youre just like, Huh?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/psyduk_superhero_01_863c9daa7f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYSUIDUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PYSUIDUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

