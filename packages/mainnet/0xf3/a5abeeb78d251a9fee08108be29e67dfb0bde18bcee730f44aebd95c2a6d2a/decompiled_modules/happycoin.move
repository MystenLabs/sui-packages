module 0xf3a5abeeb78d251a9fee08108be29e67dfb0bde18bcee730f44aebd95c2a6d2a::happycoin {
    struct HAPPYCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPPYCOIN>(arg0, 9, b"HAPPYCOIN", b"HAPPY COIN", b"It is a meme coin, in future it will be given to community via telegram app named HAPPY FACE. Basically it is a app which will give people an opportunity to smile on their mobile camera through mirror of that app.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c11a0bf-4535-426b-8945-1cdef1001080.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPYCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAPPYCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

