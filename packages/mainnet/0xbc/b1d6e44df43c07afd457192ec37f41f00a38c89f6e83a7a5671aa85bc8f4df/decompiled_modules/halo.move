module 0xbcb1d6e44df43c07afd457192ec37f41f00a38c89f6e83a7a5671aa85bc8f4df::halo {
    struct HALO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALO>(arg0, 6, b"HALO", b"HALO AI", b"Halo, where advanced technology meets existential threats and questions of divinity. Discover the sacred relics of the Covenant, humanity's immense dangers, and the sci-fi legacy that inspires faith, science, and resilience", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0523_0521e12221.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALO>>(v1);
    }

    // decompiled from Move bytecode v6
}

