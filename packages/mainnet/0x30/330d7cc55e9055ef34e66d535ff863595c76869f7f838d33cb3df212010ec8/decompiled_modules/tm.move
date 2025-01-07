module 0x30330d7cc55e9055ef34e66d535ff863595c76869f7f838d33cb3df212010ec8::tm {
    struct TM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TM>(arg0, 9, b"TM", b"Temple ", x"4974e280997320612070726f6d6973696e6720746f6b656e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61d37d10-8452-4417-8275-b06b9e3f5049.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TM>>(v1);
    }

    // decompiled from Move bytecode v6
}

