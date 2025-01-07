module 0xeced953464128a9e2ab8e64699a1a653ab2c417a1ce016d17a313a60eae4f8a9::wene {
    struct WENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WENE>(arg0, 9, b"WENE", b"WINCAT", b"WINCAT is a meme create for the wellbeing of the community and all we will do is for the community and community ALONE..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/391151b8-00cd-4074-84b8-9e638c5bfd0d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

