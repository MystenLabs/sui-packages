module 0xc2d8f657be878c3a2605826a24d3cd0706ba867854d185436ef58fae2881b80c::astroby {
    struct ASTROBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASTROBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASTROBY>(arg0, 6, b"ASTROBY", b"Astro Baby", b"Just a Astro Baby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028314_80ffccd4b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASTROBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASTROBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

