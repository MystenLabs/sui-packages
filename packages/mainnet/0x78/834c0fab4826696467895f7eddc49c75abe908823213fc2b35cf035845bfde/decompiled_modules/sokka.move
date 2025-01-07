module 0x78834c0fab4826696467895f7eddc49c75abe908823213fc2b35cf035845bfde::sokka {
    struct SOKKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOKKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOKKA>(arg0, 9, b"SOKKA", b"Sokka", b"Water tribe legend ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6fe7a2d2-2c37-4680-a092-1d00a5e22dd4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOKKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOKKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

