module 0x93a4218b377d5e098a75d2eb59664863de46f7fada73e598e5dc24dfe9e47d7b::trn {
    struct TRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRN>(arg0, 9, b"TRN", b"train", x"416c6c2061626f617264207769746820547261696e436f696e3a205468652063727970746f63757272656e637920746861742773206f6e20747261636b20746f2064656c6976657220686967682d73706565642070726f6669747320616e642065787072657373206d656d652066756e20746f20616c6c206974732070617373656e676572732120f09f9a82f09f92b8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/869d4c68-00bf-4ad8-a064-4ce2667ca30d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

