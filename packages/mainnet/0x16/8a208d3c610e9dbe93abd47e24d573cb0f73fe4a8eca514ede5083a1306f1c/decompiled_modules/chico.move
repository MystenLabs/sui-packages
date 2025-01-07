module 0x168a208d3c610e9dbe93abd47e24d573cb0f73fe4a8eca514ede5083a1306f1c::chico {
    struct CHICO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICO>(arg0, 9, b"CHICO", b"Chico", b"Just chico coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c3d62db7-2cfa-4a4c-a5c6-ec67585d8c8a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHICO>>(v1);
    }

    // decompiled from Move bytecode v6
}

