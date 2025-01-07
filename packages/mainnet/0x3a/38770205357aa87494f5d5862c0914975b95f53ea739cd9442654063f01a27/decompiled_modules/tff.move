module 0x3a38770205357aa87494f5d5862c0914975b95f53ea739cd9442654063f01a27::tff {
    struct TFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFF>(arg0, 9, b"TFF", b"Bjhug", b"Yfcy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/29e90c89-d562-4eb2-8478-957b347b6358.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

