module 0x45a789313ff114f299f2e2bd77d0587737c5d4059bfaaf13da2f24b6294e7138::astr {
    struct ASTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASTR>(arg0, 9, b"ASTR", b"Astrid", b"Blockchain kitty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ead6f936-5802-49f4-88cc-8eaf4845c8a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

