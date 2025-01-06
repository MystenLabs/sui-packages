module 0xb1770e6bdf3e81e47432f58cfe0f104e3a962b78449064053a9f3b8a5b85f197::natali {
    struct NATALI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NATALI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NATALI>(arg0, 6, b"NATALI", b"Natali.sui The Jeet", b"Natali.sui,one of the most famous jeet on Turbos.fun.Today he fxxked by ALIENCAT ($ACAT) and lose 220 Sui which cant sell.Let's fxxk him together!LOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736188095898.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NATALI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NATALI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

