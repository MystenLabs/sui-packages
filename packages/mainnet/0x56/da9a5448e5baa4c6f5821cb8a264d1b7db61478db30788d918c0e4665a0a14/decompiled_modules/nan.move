module 0x56da9a5448e5baa4c6f5821cb8a264d1b7db61478db30788d918c0e4665a0a14::nan {
    struct NAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAN>(arg0, 9, b"NAN", b"Nani", b"Nani the hero", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c1f9e60d-f329-4fe5-95bd-003726bbea90.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

