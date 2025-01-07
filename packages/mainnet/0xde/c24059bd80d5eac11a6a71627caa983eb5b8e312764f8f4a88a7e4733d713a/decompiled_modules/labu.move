module 0xdec24059bd80d5eac11a6a71627caa983eb5b8e312764f8f4a88a7e4733d713a::labu {
    struct LABU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABU>(arg0, 9, b"LABU", b"Labubu", b"meme labubu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/764b7453-f25e-4878-9c7f-9d45a86d65d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LABU>>(v1);
    }

    // decompiled from Move bytecode v6
}

