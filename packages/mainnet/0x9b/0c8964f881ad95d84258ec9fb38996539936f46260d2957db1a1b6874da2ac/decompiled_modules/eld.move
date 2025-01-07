module 0x9b0c8964f881ad95d84258ec9fb38996539936f46260d2957db1a1b6874da2ac::eld {
    struct ELD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELD>(arg0, 6, b"ELD", b"Elon Deng", b"a meme coin inspired by Moodeng (the now famous bouncing Pygmy Hippo) featuring the head of Elon Musk and called Elondeng (bouncing Elon). A new creature Combining Moodeng and Musk's recent bouncing stunts on stage during a Trump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730964200369.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

