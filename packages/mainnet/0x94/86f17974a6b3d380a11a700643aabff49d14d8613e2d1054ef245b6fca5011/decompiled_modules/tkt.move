module 0x9486f17974a6b3d380a11a700643aabff49d14d8613e2d1054ef245b6fca5011::tkt {
    struct TKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKT>(arg0, 9, b"TKT", b"TikTok", b"For all, let's do it great", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0b8653b2-5b4f-408f-8905-01a8d132d1f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

