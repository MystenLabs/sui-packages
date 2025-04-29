module 0xe24608e92646cb8d6d3c6a383ba362b45e7edbc8219e6a96d3b5c40032910a74::grusy {
    struct GRUSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUSY>(arg0, 6, b"GRUSY", b"Sui Grusy", b"No fomo. No stres . Just vibes. Join the tribe stay cool with Grusy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250429_124104_cd398b2d33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRUSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

