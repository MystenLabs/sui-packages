module 0xea08241247e30dc26b109e0a973e1b4bdd03661e526c0d2362146e2f9a3e97f9::sbr {
    struct SBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBR>(arg0, 9, b"SBR", b"Ssoberry ", x"486176652061206e6963652064617920f09f9297f09f9297f09f9297", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d97c90d-4df5-4133-a1b3-3680c053905a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

