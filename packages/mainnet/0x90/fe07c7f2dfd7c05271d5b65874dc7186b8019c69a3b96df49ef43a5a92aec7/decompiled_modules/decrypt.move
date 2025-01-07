module 0x90fe07c7f2dfd7c05271d5b65874dc7186b8019c69a3b96df49ef43a5a92aec7::decrypt {
    struct DECRYPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DECRYPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DECRYPT>(arg0, 9, b"DECRYPT", b"De cryp", b"Community token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/905b4682-4f3a-452b-93d2-43220bab6313.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DECRYPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DECRYPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

