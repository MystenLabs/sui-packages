module 0x9c458f9f4346825e39e7f07e40d921d1eea270a395f6e26c61c178411623b0de::asdadss {
    struct ASDADSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDADSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDADSS>(arg0, 9, b"ASDADSS", b"ASDF", b"ASDADS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82ed261f-e225-44fc-a5f2-7f9a26dd0f35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDADSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDADSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

