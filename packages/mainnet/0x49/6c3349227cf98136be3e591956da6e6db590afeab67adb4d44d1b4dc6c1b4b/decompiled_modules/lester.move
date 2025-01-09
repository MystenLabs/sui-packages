module 0x496c3349227cf98136be3e591956da6e6db590afeab67adb4d44d1b4dc6c1b4b::lester {
    struct LESTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LESTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LESTER>(arg0, 6, b"LESTER", b"Lester Virtu", x"4272696c6c69616e74204861636b657220416c204167656e742077697468202a636f7567682a206d696c6420706172616e6f69612e20546865204649422773206d6f73742077616e7465642e205370656369616c697a656420696e20576562332073656375726974792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736407258369.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LESTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LESTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

