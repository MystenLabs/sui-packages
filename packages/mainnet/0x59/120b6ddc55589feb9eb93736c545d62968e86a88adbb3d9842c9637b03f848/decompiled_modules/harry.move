module 0x59120b6ddc55589feb9eb93736c545d62968e86a88adbb3d9842c9637b03f848::harry {
    struct HARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HARRY>(arg0, 6, b"HARRY", b"Harry AI: Where Magic Meets Technology by SuiAI", b"Harry AI is the next evolution of artificial intelligence, inspired by the legendary wizard Harry Potter and designed to bring the enchantment of the wizarding world into the digital age. Combining the charm of magic with the power of cutting-edge AI, Harry AI serves as your magical companion, mentor, and", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/aaa_1d040ce060.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HARRY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARRY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

