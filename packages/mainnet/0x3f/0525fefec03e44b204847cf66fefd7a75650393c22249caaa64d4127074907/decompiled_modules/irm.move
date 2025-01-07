module 0x3f0525fefec03e44b204847cf66fefd7a75650393c22249caaa64d4127074907::irm {
    struct IRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRM>(arg0, 9, b"IRM", b"IRONMAN", b"NEW IRON MAN COMING ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9042aac4-39a3-445c-bdcb-0343c65b7e34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

