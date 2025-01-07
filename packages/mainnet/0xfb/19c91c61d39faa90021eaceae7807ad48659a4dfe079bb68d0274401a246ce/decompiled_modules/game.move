module 0xfb19c91c61d39faa90021eaceae7807ad48659a4dfe079bb68d0274401a246ce::game {
    struct GAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAME>(arg0, 9, b"GAME", b"Enthusiast", b"GamesEnthusiast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2b69465-2b2e-479f-889b-f51f28f608da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

