module 0x34853334060506d028bb76a31e3e382736bdd66c753dfbe0716010c40801aa6e::suiduck {
    struct SUIDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDUCK>(arg0, 6, b"SUIDUCK", b"$UIDUCK", b"This token for community who love DUCK and $SUI. Pump this duck.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_28_21_17_27_A_humorous_avatar_design_featuring_a_yellow_duck_wearing_a_pair_of_pixelated_sunglasses_and_a_large_gold_necklace_with_a_dollar_sign_pendant_The_5efc585b26.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

