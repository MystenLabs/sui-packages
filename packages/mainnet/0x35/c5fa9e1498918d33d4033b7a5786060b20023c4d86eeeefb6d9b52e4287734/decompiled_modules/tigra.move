module 0x35c5fa9e1498918d33d4033b7a5786060b20023c4d86eeeefb6d9b52e4287734::tigra {
    struct TIGRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGRA>(arg0, 9, b"TIGRA", b"TigraCat", b"My cat is a Scottish straight named tigger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5049004-b068-4921-ab91-8ad864d838a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIGRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

