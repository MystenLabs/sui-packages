module 0x31b61df7c32bcd5f4b3733d1d639271bb3edb40acbcbee350222091c43903f2d::mm {
    struct MM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MM>(arg0, 9, b"MM", b"Dog", b"Meme culture wewe ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/27b5b490-3346-43b6-a878-dd5948842a0b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MM>>(v1);
    }

    // decompiled from Move bytecode v6
}

