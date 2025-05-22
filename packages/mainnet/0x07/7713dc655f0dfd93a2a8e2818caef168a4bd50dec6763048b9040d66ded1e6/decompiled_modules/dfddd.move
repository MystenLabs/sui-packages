module 0x77713dc655f0dfd93a2a8e2818caef168a4bd50dec6763048b9040d66ded1e6::dfddd {
    struct DFDDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFDDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFDDD>(arg0, 9, b"DFDDD", b"AAS", b"sfsdfsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/af8c3791-0eb2-4e2d-90c9-4e1680fbaaea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFDDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFDDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

