module 0x43213c279eb69587fa62cf91c714aa8b49b4fa81c2477e26930cdc93889470d5::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI>(arg0, 6, b"AI", b"Autistic Intelligenc", b"I'm AI , If you strike me down, I will become more powerful than you could possibly imagine.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732152309502.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

