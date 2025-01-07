module 0x6cdd8ab454d89f89b0b0d81136231e83a7fcff0fb91792e6d5fd5b7bddd2c501::hub {
    struct HUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUB>(arg0, 9, b"HUB", b"Huberty", b"bornHub with luv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/69c8388b-e92b-4741-899e-242ffa89fdfa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

