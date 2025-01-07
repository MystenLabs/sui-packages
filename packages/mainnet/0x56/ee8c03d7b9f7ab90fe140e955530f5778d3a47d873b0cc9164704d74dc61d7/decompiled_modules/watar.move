module 0x56ee8c03d7b9f7ab90fe140e955530f5778d3a47d873b0cc9164704d74dc61d7::watar {
    struct WATAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATAR>(arg0, 9, b"WATAR", b"WAVE AVATA", b"Meme avatar  sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b941dff2-61eb-4d0d-9b23-6951f17a3fe1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

