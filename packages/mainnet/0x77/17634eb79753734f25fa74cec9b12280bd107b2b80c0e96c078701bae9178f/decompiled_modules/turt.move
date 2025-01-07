module 0x7717634eb79753734f25fa74cec9b12280bd107b2b80c0e96c078701bae9178f::turt {
    struct TURT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURT>(arg0, 6, b"TURT", b"TurtleCoin", b"Hey there! I'm Turbo the Turtle, your eco-friendly crypto buddy cruising the blockchain waves! With TurtleCoin ($TURT), I'm here to make the world a greener place, one cute flipper at a time. Join my shell squad, and together, we'll save the oceans.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949714644.03")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

