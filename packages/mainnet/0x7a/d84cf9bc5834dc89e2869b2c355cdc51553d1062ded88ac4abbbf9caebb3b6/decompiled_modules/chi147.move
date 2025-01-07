module 0x7ad84cf9bc5834dc89e2869b2c355cdc51553d1062ded88ac4abbbf9caebb3b6::chi147 {
    struct CHI147 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHI147, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHI147>(arg0, 9, b"CHI147", b"Chizzy", b"Simplicity ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b95fc565-6fac-413c-a22f-cdf6cb525421.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHI147>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHI147>>(v1);
    }

    // decompiled from Move bytecode v6
}

