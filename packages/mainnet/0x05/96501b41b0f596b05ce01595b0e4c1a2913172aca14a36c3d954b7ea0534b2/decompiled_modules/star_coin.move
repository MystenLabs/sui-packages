module 0x596501b41b0f596b05ce01595b0e4c1a2913172aca14a36c3d954b7ea0534b2::star_coin {
    struct STAR_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAR_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAR_COIN>(arg0, 9, b"STAR_COIN", b"STAR-NET", b"Jamesoclock crypto exchange tested and trusted ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/16b2c20a-94b2-4284-8d6a-92b6ff8f13f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAR_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STAR_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

