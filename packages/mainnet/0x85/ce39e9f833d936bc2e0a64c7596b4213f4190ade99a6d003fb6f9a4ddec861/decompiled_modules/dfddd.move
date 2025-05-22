module 0x85ce39e9f833d936bc2e0a64c7596b4213f4190ade99a6d003fb6f9a4ddec861::dfddd {
    struct DFDDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFDDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFDDD>(arg0, 9, b"DFDDD", b"AAS", b"sfsdfsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/57e3ba26-cb30-43ce-be2b-fc7ad40d2326.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFDDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFDDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

