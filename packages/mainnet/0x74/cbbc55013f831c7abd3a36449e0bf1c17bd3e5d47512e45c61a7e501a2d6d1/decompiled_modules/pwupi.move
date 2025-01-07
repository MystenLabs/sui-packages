module 0x74cbbc55013f831c7abd3a36449e0bf1c17bd3e5d47512e45c61a7e501a2d6d1::pwupi {
    struct PWUPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWUPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWUPI>(arg0, 6, b"PWUPI", b"PWUPPI", b"$Pwuppy along with his crew of super memes, petrol the city of Sui, looking for coins worthly of joining the justice memeleague of billions super heros.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_d28defa511.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWUPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWUPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

