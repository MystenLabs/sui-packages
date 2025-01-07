module 0xcabc370e2dbba1a9a0307199bc2a11b4331043c51ecc7002cc6414a6cd1cea46::lcc {
    struct LCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LCC>(arg0, 6, b"LCC", b"Life Cycle Coin", b"\"Life Cycle Coin is a cryptocurrency symbolizing the eternal cycle of life, death, and rebirth. Inspired by the philosophical and spiritual teachings of various cultures, it represents the continuous flow of existence and the balance between life and death.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_24_22_33_12_084e33468d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

