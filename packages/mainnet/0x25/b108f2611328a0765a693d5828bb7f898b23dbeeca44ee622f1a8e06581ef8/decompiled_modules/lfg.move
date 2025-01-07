module 0x25b108f2611328a0765a693d5828bb7f898b23dbeeca44ee622f1a8e06581ef8::lfg {
    struct LFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFG>(arg0, 6, b"Lfg", b"lfg", b"yooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731448030266.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LFG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

