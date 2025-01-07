module 0xb45189e8653daf228ad2738325630eac5042b2318902fc61b44693446c3f3333::lb {
    struct LB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LB>(arg0, 9, b"LB", b"Langbo", b"For the cause ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cec42d52-088f-4c05-8a2e-2bb1c9ca52a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LB>>(v1);
    }

    // decompiled from Move bytecode v6
}

