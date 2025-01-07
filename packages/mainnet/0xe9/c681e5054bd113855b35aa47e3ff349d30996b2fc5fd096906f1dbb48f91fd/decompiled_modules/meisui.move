module 0xe9c681e5054bd113855b35aa47e3ff349d30996b2fc5fd096906f1dbb48f91fd::meisui {
    struct MEISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEISUI>(arg0, 6, b"MEISUI", x"4d656953756920e6b2a1e6b0b4", x"4d65692053756920e6b2a1e6b0b43a204e6f2053554920696e20796f75722077616c6c65742c206e6f20776f7272696573e280946a7573742073636172636974792c20736d696c65732c20616e64206472792068756d6f72", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731235894878.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEISUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEISUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

