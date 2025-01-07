module 0x1a468b50c52728f7e3c84720b148cce50e714f3d59b22e9c8420003d5dd56993::dogeclown {
    struct DOGECLOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGECLOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGECLOWN>(arg0, 9, b"DOGECLOWN", b"DoGeclown", b"is DoGe but we are all clowns in this world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fdb98da5-9589-4e41-ad53-ac9811398c77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGECLOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGECLOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

