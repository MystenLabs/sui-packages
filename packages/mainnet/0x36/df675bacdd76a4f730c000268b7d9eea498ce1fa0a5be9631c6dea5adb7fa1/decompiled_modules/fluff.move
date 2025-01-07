module 0x36df675bacdd76a4f730c000268b7d9eea498ce1fa0a5be9631c6dea5adb7fa1::fluff {
    struct FLUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFF>(arg0, 6, b"FLUFF", b"Fluff", b"$FLUFF, the father of Sui, found the first Sui coin deep in the ocean. He built the Sui ecosystem and now protects its waters, ensuring all creatures thrive!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_1ce7790e48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

