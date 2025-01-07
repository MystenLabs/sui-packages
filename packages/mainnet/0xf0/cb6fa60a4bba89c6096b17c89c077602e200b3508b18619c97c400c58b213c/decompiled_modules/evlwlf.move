module 0xf0cb6fa60a4bba89c6096b17c89c077602e200b3508b18619c97c400c58b213c::evlwlf {
    struct EVLWLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVLWLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVLWLF>(arg0, 9, b"EVLWLF", b"EvilWolf", b"a very evil wolf ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5cc0ab84-02b3-40de-99d1-e16a4497a4c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVLWLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVLWLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

