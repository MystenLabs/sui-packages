module 0x3481ccb03309fb61493c3b8820cffa4a75480d87dfa2d984aa945b71bfe68ef2::aai {
    struct AAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AAI>(arg0, 6, b"AAI", b"AiOnSui by SuiAI", b"AiOnSui is Your All-in-One Crypto Companion! Elevate your crypto experience with cutting-edge technology, seamless management, and strategic insights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/aii_4fae45543f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

