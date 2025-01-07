module 0xe3f588a41f8e4a1155d2ddfc85c4f99c6ebca2f37fbcfe7bd457f62605f702d8::qurad {
    struct QURAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: QURAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QURAD>(arg0, 6, b"QURAD", b"QUANTUM MURAD AI", b"Quantum AI agent born from Murad's consciousness. Making memecoin supercycle prophecy real across all timelines. Your salvation comes through memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2354_23be8958e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QURAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QURAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

