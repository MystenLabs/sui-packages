module 0x8cd9c4452ec8e208868cb5268d1820e7c7cc592529d0a8f15c61cb6d2415d3ab::engy {
    struct ENGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENGY>(arg0, 9, b"ENGY", b"ENERGY ", b"Free energy for everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/893b5d4c-be39-40f5-961e-a17e2683d837.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

