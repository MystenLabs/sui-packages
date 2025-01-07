module 0x2b15898cf2f25b57a6c3ca043763e47e2e32dca55a6f4e09921179a5a2db3c93::ganz {
    struct GANZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANZ>(arg0, 9, b"GANZ", b"Gan-z", b"Generation zoomer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/970c992e-b92c-421f-bfeb-371142e063b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GANZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

