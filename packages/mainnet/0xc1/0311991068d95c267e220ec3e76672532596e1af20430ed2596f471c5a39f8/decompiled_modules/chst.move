module 0xc10311991068d95c267e220ec3e76672532596e1af20430ed2596f471c5a39f8::chst {
    struct CHST has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHST>(arg0, 9, b"CHST", b"CHEST", b"Treasure chest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67fb2c3d-e677-451a-ad6c-8b58365d3f91.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHST>>(v1);
    }

    // decompiled from Move bytecode v6
}

