module 0xaeb0ea3a94f4d67951ab522d0626d1cc93d83d7607469ddd3b50d95ed0e20bb3::foxy {
    struct FOXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXY>(arg0, 6, b"FOXY", b"Sui Foxy", b"Sly and sharp, Sui Foxy is quick on its feet, always one step ahead. A clever little fox on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fox_c2736d032e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

