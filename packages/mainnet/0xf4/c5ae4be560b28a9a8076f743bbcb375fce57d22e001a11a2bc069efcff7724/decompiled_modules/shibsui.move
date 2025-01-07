module 0xf4c5ae4be560b28a9a8076f743bbcb375fce57d22e001a11a2bc069efcff7724::shibsui {
    struct SHIBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBSUI>(arg0, 9, b"SHIBSUI", b"ShibSui", b"A sui memecoin with big dreams a community meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e784f908-846e-4459-94cc-bccb3da913e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

