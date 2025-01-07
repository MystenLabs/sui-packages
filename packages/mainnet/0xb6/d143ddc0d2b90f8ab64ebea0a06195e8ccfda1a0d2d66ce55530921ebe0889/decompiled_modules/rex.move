module 0xb6d143ddc0d2b90f8ab64ebea0a06195e8ccfda1a0d2d66ce55530921ebe0889::rex {
    struct REX has drop {
        dummy_field: bool,
    }

    fun init(arg0: REX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REX>(arg0, 6, b"REX", b"SuiRex", b"$REX is a playful yet powerful token on the SUI network, symbolized by a charming dinosaur mascot. Blending the strength of a prehistoric creature with modern crypto appeal, $REX represents resilience and adaptability in the fast-paced world of blockchain. This token is designed to attract a dynamic community, drawn by its unique combination of nostalgia and forward-thinking innovation. With a sleek, minimalist design, $REX captures the essence of evolutionwhere the past meets the future in the digital age, offering a fun yet impactful experience for crypto enthusiasts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_01_56_05_2aa863fe01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REX>>(v1);
    }

    // decompiled from Move bytecode v6
}

