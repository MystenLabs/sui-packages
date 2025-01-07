module 0x33b464f496d389083e2b396055bbf80f5a8b6ff0c78d6a544bc2ac09ce4d476b::chine {
    struct CHINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHINE>(arg0, 6, b"CHINE", b"NEIRO CHINE", b"NEIRO IS CHINE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6296580665239520047_ebb1c9db61.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

