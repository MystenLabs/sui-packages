module 0xe90bceabee281f0689bfb9b8c3b75a71dd2a7c91684563cc5e38fe5141ec2fd5::fsl {
    struct FSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSL>(arg0, 6, b"FSL", b"Icarus Neutral Vault LP", b"LP token for Icarus Neutral Vault", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

