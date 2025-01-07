module 0x39a7cd052ffe43f9a079950d17b9f453b7cc8d115fee63b972a6b54a705649e6::hero {
    struct HERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HERO>(arg0, 9, b"HERO", b"HeroHero", b"IM YOUR HERO , BUY ME AND HOLD ME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82287b9d-0937-41f1-98c7-aeec95990c39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HERO>>(v1);
    }

    // decompiled from Move bytecode v6
}

