module 0x1d87a3e3adfb25e5d765739d50fdd5e708109aecc69be19bf17ff53af413993d::sonek {
    struct SONEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONEK>(arg0, 6, b"SONEK", b"Sonek Relaunch", b"Whether you're a crypto expert or just starting your journey, the Sonek Coin community welcomes you. Together, were building a future where fun meets innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033457_0a9650dd38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

