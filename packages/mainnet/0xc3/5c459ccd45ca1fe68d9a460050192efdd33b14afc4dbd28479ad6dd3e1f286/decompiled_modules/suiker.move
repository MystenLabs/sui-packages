module 0xc35c459ccd45ca1fe68d9a460050192efdd33b14afc4dbd28479ad6dd3e1f286::suiker {
    struct SUIKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKER>(arg0, 6, b"SUIKER", b"BIRD DOG SMUIKER", b"Dive into the vibrant and playful world of BIRD DOG SMOKER, a meme coin inspired by Matt Furies whimsical creation. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1080x360_a5242aa269.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

