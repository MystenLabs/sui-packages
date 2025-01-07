module 0x497dd2365e25dd22a522c9db203dffecb53768784445a6fb345ce1f3ab901808::pwkdb {
    struct PWKDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWKDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWKDB>(arg0, 9, b"PWKDB", b"hdjene", b"ebjej", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4a6881f0-9e5f-4570-8646-8b343011587d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWKDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWKDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

