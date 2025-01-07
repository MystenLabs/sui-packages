module 0x5acfa78e390a4e47ae2e1f5aff13078bbd8dea4c88c6949661bcb819c9732e0c::fomofrog_5 {
    struct FOMOFROG_5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMOFROG_5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMOFROG_5>(arg0, 9, b"FOMOFROG_5", b"FomoFrog", b"Hope on before it's gone!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6fbbcaa9-4ff6-446e-99b9-c5c2acbcc493.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMOFROG_5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOMOFROG_5>>(v1);
    }

    // decompiled from Move bytecode v6
}

