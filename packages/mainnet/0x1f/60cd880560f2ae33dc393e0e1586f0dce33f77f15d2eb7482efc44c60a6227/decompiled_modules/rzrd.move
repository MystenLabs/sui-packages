module 0x1f60cd880560f2ae33dc393e0e1586f0dce33f77f15d2eb7482efc44c60a6227::rzrd {
    struct RZRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RZRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RZRD>(arg0, 9, b"RZRD", b"RainbowLiz", b" The most colorful crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a403ddea-cb46-4801-a362-aeb2d9797a81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RZRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RZRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

