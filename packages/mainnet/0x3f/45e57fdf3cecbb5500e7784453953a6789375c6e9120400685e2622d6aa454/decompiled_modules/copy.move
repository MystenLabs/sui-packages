module 0x3f45e57fdf3cecbb5500e7784453953a6789375c6e9120400685e2622d6aa454::copy {
    struct COPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COPY>(arg0, 9, b"COPY", b"Copy Past", b"Copy Past Copy Past Copy Past", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5544a289-4e91-4d02-8db6-e37d7f246651.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

