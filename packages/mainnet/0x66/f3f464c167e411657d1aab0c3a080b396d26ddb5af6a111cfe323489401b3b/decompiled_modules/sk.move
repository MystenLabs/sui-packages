module 0x66f3f464c167e411657d1aab0c3a080b396d26ddb5af6a111cfe323489401b3b::sk {
    struct SK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SK>(arg0, 9, b"SK", b"Slam ", b"End of story for the ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9717930-3838-4505-a57c-7ed5e56d21a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SK>>(v1);
    }

    // decompiled from Move bytecode v6
}

