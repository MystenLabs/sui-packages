module 0xfeeb7d7deef9efbb62d7c4c33c65c0f6a460d7c71f384ca797b4d25e1fe0f79e::rzrd {
    struct RZRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RZRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RZRD>(arg0, 9, b"RZRD", b"RainbowLiz", b" The most colorful crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e8a9c17-75b9-459f-826f-808900862195.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RZRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RZRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

