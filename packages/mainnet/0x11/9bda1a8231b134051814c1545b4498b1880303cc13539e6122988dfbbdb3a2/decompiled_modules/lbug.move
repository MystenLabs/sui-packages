module 0x119bda1a8231b134051814c1545b4498b1880303cc13539e6122988dfbbdb3a2::lbug {
    struct LBUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBUG>(arg0, 9, b"LBUG", b"LANOCHIM", b"Let's make community together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/df2c89fe-9c4f-47a9-b197-0ac14185ab36.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LBUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

