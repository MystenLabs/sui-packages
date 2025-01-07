module 0x4090ebaccd51ee277cca62a68f80c0b4cb9292a83c6ff92994ccf16981047222::truonghs {
    struct TRUONGHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUONGHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUONGHS>(arg0, 9, b"TRUONGHS", b"pumbaa", x"5468e1baa76e20647520687579e1bb816e2063e1baa36e68", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78931810-d998-48b8-b54c-7b1049ac347b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUONGHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUONGHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

