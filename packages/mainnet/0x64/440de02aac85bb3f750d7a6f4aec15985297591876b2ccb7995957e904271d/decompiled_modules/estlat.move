module 0x64440de02aac85bb3f750d7a6f4aec15985297591876b2ccb7995957e904271d::estlat {
    struct ESTLAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESTLAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESTLAT>(arg0, 9, b"ESTLAT", b"EstlatCoin", b"First coin of Esther ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c1014aa-90b5-4845-9b97-e1dc63ff5e87.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESTLAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ESTLAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

