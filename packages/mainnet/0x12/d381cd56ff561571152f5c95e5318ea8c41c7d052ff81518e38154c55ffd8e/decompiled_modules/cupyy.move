module 0x12d381cd56ff561571152f5c95e5318ea8c41c7d052ff81518e38154c55ffd8e::cupyy {
    struct CUPYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUPYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUPYY>(arg0, 9, b"CUPYY", b"Cooopy", b"Great cupy meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c6fac55-6076-4822-89df-0ad9c5e4f0c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUPYY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUPYY>>(v1);
    }

    // decompiled from Move bytecode v6
}

