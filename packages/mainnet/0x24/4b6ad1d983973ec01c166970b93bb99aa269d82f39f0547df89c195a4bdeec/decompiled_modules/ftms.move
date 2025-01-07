module 0x244b6ad1d983973ec01c166970b93bb99aa269d82f39f0547df89c195a4bdeec::ftms {
    struct FTMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTMS>(arg0, 9, b"FTMS", b"Fatimas", b"Ftmstoke ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b018fb61-011e-4248-a019-7ebc4464777b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FTMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

