module 0xd1695534952f924a73f5dacd9a573f5c213ff8ed3a2553c248f65527432754f2::aig {
    struct AIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIG>(arg0, 6, b"AIG", b"AiOnSui Agent by SuiAI", b"AiOnSui is Your All-in-One Crypto Companion! Elevate your crypto experience with cutting-edge technology, seamless management, and strategic insights...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/aai_x4_d394f6265a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

