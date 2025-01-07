module 0xb8e8a92acd391fd447cca2b79a86d382e7c3018b6a6f246b16d9e3ee9dfe5372::oceanpepe {
    struct OCEANPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEANPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCEANPEPE>(arg0, 6, b"OCEANPEPE", b"Ocean pepe", b"The king of the ocean is here, with the backing of the strongest community. Born from innovation, transparency, and resilience, OceanPepe launched on Pump.Fun with our Doxxed founder live-streaming four days straight to reach the Raydium milestone, reflecting our commitment to success", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036348_cb3586d6de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCEANPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCEANPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

