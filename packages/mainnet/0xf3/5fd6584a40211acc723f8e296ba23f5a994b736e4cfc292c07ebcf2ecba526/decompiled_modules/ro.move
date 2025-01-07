module 0xf35fd6584a40211acc723f8e296ba23f5a994b736e4cfc292c07ebcf2ecba526::ro {
    struct RO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RO>(arg0, 9, b"RO", b"Worst ", x"4920646f6ee2809974207468696e6b20736f20627574204920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c326ffc1-4ed3-409f-b045-4681b0bf4571.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RO>>(v1);
    }

    // decompiled from Move bytecode v6
}

