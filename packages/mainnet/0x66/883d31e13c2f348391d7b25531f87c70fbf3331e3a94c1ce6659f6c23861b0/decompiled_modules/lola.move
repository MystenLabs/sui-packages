module 0x66883d31e13c2f348391d7b25531f87c70fbf3331e3a94c1ce6659f6c23861b0::lola {
    struct LOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLA>(arg0, 6, b"LOLA", b"LOLA ON SUI", b"LOLA ON SUI is a beloved cat by Matt Furie. The most impressive character of his comic editions! She loves to purr and sharpen her claws on jeets!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_tick_7c08b8fdc1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

