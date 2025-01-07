module 0x75fc338ed19e1ee4e4c922edbf665b52f13060bd5c2416a7ee79621afcc5e43c::dlph {
    struct DLPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLPH>(arg0, 9, b"DLPH", b"Dolphin", b"Dophines are smart and they love to make friends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/55cefca3-fb5d-482b-9825-404b29241d89.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DLPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

