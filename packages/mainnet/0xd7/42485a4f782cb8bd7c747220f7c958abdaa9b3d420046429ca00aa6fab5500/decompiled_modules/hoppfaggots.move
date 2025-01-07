module 0xd742485a4f782cb8bd7c747220f7c958abdaa9b3d420046429ca00aa6fab5500::hoppfaggots {
    struct HOPPFAGGOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPFAGGOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPFAGGOTS>(arg0, 6, b"HOPPFAGGOTS", b"HOP.CLOWNS", b"WTFWTF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fuck_hop_fun_a7b6e11b70.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPFAGGOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPFAGGOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

