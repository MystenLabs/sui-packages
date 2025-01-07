module 0x5057cf933749ac298b1c06c7b908cbc879bb2ff619993bbdfbbc1973a246b066::ocean {
    struct OCEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCEAN>(arg0, 6, b"Ocean", b"Ocean Gate", b"Just a sub", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/72332533_0_Authorities_raised_the_alarm_on_Sunday_when_an_Ocean_Gate_Titan_v_a_36_1687346867641_df8ac10a34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

