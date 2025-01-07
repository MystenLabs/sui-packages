module 0xe6661f9c76f1db22ed6114333c083f66f233227ee913e608169beff245a2ee12::cheems {
    struct CHEEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEMS>(arg0, 6, b"CHEEMS", b"SUI CHEEMS", b"SUI CHEEMS is a fully community driven project built on the Sui blockchain. Inspired by the iconic internet meme, Cheems the dog, this project aims to capture the nostalgic spirit and community-driven ethos that characterized the early days of cryptocurrencies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6100585e_543e_48e6_be47_506571dfe627_dc1c8a0f5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

