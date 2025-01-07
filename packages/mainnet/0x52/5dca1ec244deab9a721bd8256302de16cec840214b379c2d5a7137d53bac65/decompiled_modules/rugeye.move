module 0x525dca1ec244deab9a721bd8256302de16cec840214b379c2d5a7137d53bac65::rugeye {
    struct RUGEYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGEYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGEYE>(arg0, 6, b"RUGEYE", b"Rugeye", b"Keep your eyes peeled with $RUGEYE! This token detects rug pulls on Movepump, providing a live Telegram bot and token contract checks. Stay safe and vigilant in your investments!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rug_Eye_Animate_d71ea62b2f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGEYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGEYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

