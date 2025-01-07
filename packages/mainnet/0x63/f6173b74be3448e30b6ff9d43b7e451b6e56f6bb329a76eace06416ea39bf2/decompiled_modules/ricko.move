module 0x63f6173b74be3448e30b6ff9d43b7e451b6e56f6bb329a76eace06416ea39bf2::ricko {
    struct RICKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKO>(arg0, 6, b"RICKO", b"SUI CHICKEN KING", b"Ricko is a meme token on the Sui, combining the image of a blue chicken of the Sui blockchain. Powered by the community, it's a lighthearted tribute to crypto culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_whimsical_illustration_featuring_a_cartooni_2_9706abaffa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

