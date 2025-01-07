module 0xefc577d3f5130ba3907269977da33c72f06cb5de3b8c8e36d8b22b670afe66c0::ass {
    struct ASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASS>(arg0, 9, b"ASS", b"Douyu", b"Pump on the token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8941cdb-13b3-49ee-9bc5-2dfb51246842.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

