module 0x4cd9d548c21391c35e588da2e4d02d14d0314fb5d33ba437e696303070788472::qris {
    struct QRIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: QRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QRIS>(arg0, 9, b"QRIS", b"MemeXQris", b"Create by ESSGabut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/442dab54-a1b8-4039-a711-41c2a2ab68aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QRIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QRIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

