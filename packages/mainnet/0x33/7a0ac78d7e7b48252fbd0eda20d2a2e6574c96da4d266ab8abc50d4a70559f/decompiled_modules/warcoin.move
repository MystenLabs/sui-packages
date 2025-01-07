module 0x337a0ac78d7e7b48252fbd0eda20d2a2e6574c96da4d266ab8abc50d4a70559f::warcoin {
    struct WARCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARCOIN>(arg0, 9, b"WARCOIN", b"WAR", b"Coin of the WAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79ff2e1e-9b33-4797-b0d3-d07c9c6c418f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

