module 0x31e4049a6478182a1fccbfc083e49398b9128368cae3cb5a7cb21082154c95cd::gwr {
    struct GWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWR>(arg0, 9, b"GWR", b"godwarrior", b"godwarrior is just fights for the god !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/81b8eab8-7861-44ea-9fda-388409e4289f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GWR>>(v1);
    }

    // decompiled from Move bytecode v6
}

