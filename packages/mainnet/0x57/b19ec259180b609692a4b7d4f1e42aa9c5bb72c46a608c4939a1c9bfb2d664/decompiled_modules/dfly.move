module 0x57b19ec259180b609692a4b7d4f1e42aa9c5bb72c46a608c4939a1c9bfb2d664::dfly {
    struct DFLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFLY>(arg0, 9, b"DFLY", b"DemonFly", b"Please trade DemonFly coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97950232-ac14-4b5f-88ad-077fecdea2a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

