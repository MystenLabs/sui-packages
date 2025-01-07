module 0x38bca2bdccdd27a481418bbdc08ec7a1a394e9f78f8ba5a547c6f66ff8b36a99::suii {
    struct SUII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUII>(arg0, 9, b"SUII", b"Sui", x"312e202a2a53756920426c6f636b636861696e2a2a3a20200a2020202d204cc3a0206de1bb9974206ee1bb816e2074e1baa36e6720626c6f636b636861696e202a2a4c6179657220312a2a2074e1bb916320c491e1bb992063616f2076c3a0207068692074e1baad70207472756e672e20200a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8bde7809-f53b-450e-84ec-3a18e9d80669.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUII>>(v1);
    }

    // decompiled from Move bytecode v6
}

