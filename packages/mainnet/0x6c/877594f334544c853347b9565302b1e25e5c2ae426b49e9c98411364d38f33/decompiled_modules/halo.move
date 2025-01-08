module 0x6c877594f334544c853347b9565302b1e25e5c2ae426b49e9c98411364d38f33::halo {
    struct HALO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALO>(arg0, 6, b"HALO", b"Halo AI", b"Halo, where advanced technology meets existential threats and questions of divinity. Discover the sacred relics of the Covenant, humanity's immense dangers, and the sci-fi legacy that inspires faith, science, and resilience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0530_45281f5376.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALO>>(v1);
    }

    // decompiled from Move bytecode v6
}

