module 0x93719c8fd235e17f39d0f373c35722dedb4cb63e355bd6898048c198c10680a7::wene {
    struct WENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WENE>(arg0, 9, b"WENE", b"WINCAT", b"WINCAT is a meme create for the wellbeing of the community and all we will do is for the community and community ALONE..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f6127b9-76cf-4ddf-a51b-149b7bc3b877.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

