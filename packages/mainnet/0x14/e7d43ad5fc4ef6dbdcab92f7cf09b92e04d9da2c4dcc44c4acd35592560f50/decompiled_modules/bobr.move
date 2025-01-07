module 0x14e7d43ad5fc4ef6dbdcab92f7cf09b92e04d9da2c4dcc44c4acd35592560f50::bobr {
    struct BOBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBR>(arg0, 9, b"BOBR", b"Bobrkur", b"BOBRKUR is a meme token inspired by the internet meme \"beaver kurwa.\" It represents resilience and humor in tough situations. The BOBRKUR community embraces creativity, meme sharing, and fun, making it the perfect token for fans of internet culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/92939de2-412d-492d-a6b6-647929f01ef0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

