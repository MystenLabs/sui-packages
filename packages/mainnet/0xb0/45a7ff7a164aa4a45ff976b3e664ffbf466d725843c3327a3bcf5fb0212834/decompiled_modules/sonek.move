module 0xb045a7ff7a164aa4a45ff976b3e664ffbf466d725843c3327a3bcf5fb0212834::sonek {
    struct SONEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONEK>(arg0, 6, b"SONEK", b"Sonek", b"Whether you're a crypto expert or just starting your journey, the Sonek Coin community welcomes you. Together, were building a future where fun meets innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241220_135011_7d33f2da96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

