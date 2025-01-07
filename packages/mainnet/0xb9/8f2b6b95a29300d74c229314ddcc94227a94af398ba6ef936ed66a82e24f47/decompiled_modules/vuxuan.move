module 0xb98f2b6b95a29300d74c229314ddcc94227a94af398ba6ef936ed66a82e24f47::vuxuan {
    struct VUXUAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VUXUAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VUXUAN>(arg0, 9, b"VUXUAN", b"Hamhamxuan", b"Xuan can tho", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3fb35f5c-937e-4e2d-947a-1878da09a6c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VUXUAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VUXUAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

