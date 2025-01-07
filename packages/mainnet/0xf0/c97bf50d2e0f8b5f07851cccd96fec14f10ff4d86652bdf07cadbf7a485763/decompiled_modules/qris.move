module 0xf0c97bf50d2e0f8b5f07851cccd96fec14f10ff4d86652bdf07cadbf7a485763::qris {
    struct QRIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: QRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QRIS>(arg0, 9, b"QRIS", b"MemeXQris", b"Create by ESSGabut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5c0068b-8cc1-4ff8-9517-3ec652541a5b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QRIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QRIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

