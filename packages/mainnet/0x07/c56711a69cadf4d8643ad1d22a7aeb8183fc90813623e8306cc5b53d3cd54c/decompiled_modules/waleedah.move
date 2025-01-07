module 0x7c56711a69cadf4d8643ad1d22a7aeb8183fc90813623e8306cc5b53d3cd54c::waleedah {
    struct WALEEDAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALEEDAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALEEDAH>(arg0, 9, b"WALEEDAH", b"Waly", b"Crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7a2c3767-aebb-4319-b87a-7cb100ba320d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALEEDAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALEEDAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

