module 0x9928f5075f9d2a931e9eaa9187e1131b0043c94fcfc5f50e04a38d814c2e75f::think {
    struct THINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: THINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THINK>(arg0, 9, b"THINK", b"Think", b"Use Your Brain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24e9b9c1-9a49-460d-9f11-0fa50b2b49e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

