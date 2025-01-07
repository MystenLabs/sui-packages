module 0x22cedc3ca7469c5fedaa9b6a970b956ba6e999f063ac2e9ea72062112f0c7f4e::hm {
    struct HM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HM>(arg0, 9, b"HM", b"Ha Mai", b"HM is token of HMcaptcha.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe207baa-ab2f-4f2a-97a4-0f96aa66dd08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HM>>(v1);
    }

    // decompiled from Move bytecode v6
}

