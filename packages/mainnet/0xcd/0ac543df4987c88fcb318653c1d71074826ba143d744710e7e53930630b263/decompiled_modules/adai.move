module 0xcd0ac543df4987c88fcb318653c1d71074826ba143d744710e7e53930630b263::adai {
    struct ADAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADAI>(arg0, 6, b"ADAI", b"AutoDev Ai", b"AutoDev: The AI-powered coding wizard", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_j_bitk_A_p_64ec63e7a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

