module 0x8bf0d490a8d39b158679f3869cc5f3d98dc5e06596ab29a3499047296a923760::tmeme {
    struct TMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMEME>(arg0, 9, b"TMEME", b"Trumpmeme", b"Trump can lead the world with trumpmeme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/305c31c8-c024-4a4c-846e-899ddcb6ca2c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

