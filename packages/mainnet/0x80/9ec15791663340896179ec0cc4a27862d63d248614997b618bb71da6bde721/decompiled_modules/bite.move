module 0x809ec15791663340896179ec0cc4a27862d63d248614997b618bb71da6bde721::bite {
    struct BITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITE>(arg0, 6, b"BITE", b"BITETAEAT", b"PRINCIPLE | MORAL | TRUST | ARTIST | PRODUCER ~ INVESTOR ~ VISIONARY ~ CINEMATOGRAPHY ~ INVEST WITH #BITE & HOP ON THIS TRAIN TO THE ! ENHANCE YOUR LIFESTYLE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0v_KUAAD_3_400x400_799fa6a171.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

