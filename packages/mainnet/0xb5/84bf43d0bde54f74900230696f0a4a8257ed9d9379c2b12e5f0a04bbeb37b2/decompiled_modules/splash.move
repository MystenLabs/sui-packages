module 0xb584bf43d0bde54f74900230696f0a4a8257ed9d9379c2b12e5f0a04bbeb37b2::splash {
    struct SPLASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASH>(arg0, 6, b"SPLASH", b"SPLASH SUI", x"4c61756e636820746f6b656e73206f6e205375692e20496e7374616e746c792e20466169726c792e0a4275696c7420666f72206275696c646572732c20646567656e732c20616e642065766572796f6e6520696e206265747765656e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig66fotlshwbgi6pvkjj373ggm6e26ji4yd6j4riny3zplssmxsfe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPLASH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

