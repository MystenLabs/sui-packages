module 0xe9478fa80ad4e95eee18bd02e1a916e31ab3942da636d7f4facce4b82a812a13::aggf {
    struct AGGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGGF>(arg0, 9, b"AGGF", b"rret", b"fdgdfgdfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0b7e3e3b-7bbf-49f8-bb71-08b28d62b837.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

