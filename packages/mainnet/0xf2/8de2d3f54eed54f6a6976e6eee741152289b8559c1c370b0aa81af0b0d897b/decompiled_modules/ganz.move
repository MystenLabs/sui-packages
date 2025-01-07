module 0xf28de2d3f54eed54f6a6976e6eee741152289b8559c1c370b0aa81af0b0d897b::ganz {
    struct GANZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANZ>(arg0, 9, b"GANZ", b"Gan-z", b"Generation zoomer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24a56f20-5b02-480e-8306-7fdd7a2e54dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GANZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

