module 0xa3f568e365349e62f76ce1305b4d1edb0b86800cfdf3bb7df035a711a781ba3f::wagey {
    struct WAGEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAGEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAGEY>(arg0, 6, b"WAGEY", b"First Wagey On Sui", b"First Wagey On Sui: https://www.wageyonsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wag_1_c9c4e187b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAGEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAGEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

