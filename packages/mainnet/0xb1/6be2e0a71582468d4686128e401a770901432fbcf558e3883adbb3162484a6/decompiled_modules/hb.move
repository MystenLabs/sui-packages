module 0xb16be2e0a71582468d4686128e401a770901432fbcf558e3883adbb3162484a6::hb {
    struct HB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HB>(arg0, 9, b"HB", b"Hung Ba", x"48c3b96e672042c3a1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49b0bea4-fcfd-44e9-b32a-7ba6d12f5d38.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HB>>(v1);
    }

    // decompiled from Move bytecode v6
}

