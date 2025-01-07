module 0x6ac3fd9ff65eea1f744198a92bf169eb2673763d7161b92c908aa921b93f2880::ogbaking1 {
    struct OGBAKING1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGBAKING1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGBAKING1>(arg0, 9, b"OGBAKING1", b"Oba", b"African culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7b25bcbe-35e4-4c6a-ae3d-4470e828ff03.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGBAKING1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGBAKING1>>(v1);
    }

    // decompiled from Move bytecode v6
}

