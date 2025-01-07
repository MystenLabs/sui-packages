module 0xab31aa820ee3f5d952f3a633bd8584d7982e0e6d58a5bc13e0877520171f5972::loopy {
    struct LOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOPY>(arg0, 9, b"LOOPY", b"LOOPY SUI", x"4c4f4f505920737569206164616c616820736562756168206b6f6d756e6974617320746f6b656e2044414f2079616e67206d656d626572696b616e203830e28485207061736f6b616e206b6570616461206b6f6d6f64697461732e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/715ba45e-bcc7-4383-8f0c-73297b81dfb4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

