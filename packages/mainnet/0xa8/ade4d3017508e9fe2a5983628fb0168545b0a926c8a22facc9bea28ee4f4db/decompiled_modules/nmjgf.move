module 0xa8ade4d3017508e9fe2a5983628fb0168545b0a926c8a22facc9bea28ee4f4db::nmjgf {
    struct NMJGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: NMJGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NMJGF>(arg0, 9, b"NMJGF", b"YTJ", b"VXC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b772b3c6-91e6-48af-883d-354db44a609d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NMJGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NMJGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

