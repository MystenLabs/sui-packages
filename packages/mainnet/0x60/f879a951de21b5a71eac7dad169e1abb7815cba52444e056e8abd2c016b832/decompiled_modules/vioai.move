module 0x60f879a951de21b5a71eac7dad169e1abb7815cba52444e056e8abd2c016b832::vioai {
    struct VIOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VIOAI>(arg0, 6, b"VIOAI", b"VIO AI by SuiAI", b"personality, memories & real-time comms for agents.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2141_d3e0340f02_782c716a42.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VIOAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIOAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

