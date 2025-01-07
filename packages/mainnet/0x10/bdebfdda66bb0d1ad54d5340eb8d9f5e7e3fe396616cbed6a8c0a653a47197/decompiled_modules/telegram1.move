module 0x10bdebfdda66bb0d1ad54d5340eb8d9f5e7e3fe396616cbed6a8c0a653a47197::telegram1 {
    struct TELEGRAM1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TELEGRAM1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TELEGRAM1>(arg0, 9, b"TELEGRAM1", b"Telegram", b"Increase active people on telegram", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d098022-2f4c-430e-b186-7725a57f7dbc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TELEGRAM1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TELEGRAM1>>(v1);
    }

    // decompiled from Move bytecode v6
}

