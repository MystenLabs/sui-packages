module 0x12a8c02f2a9cdc18a2eac1d11ca4b509776464dffa96acd0e590c8333632920e::pd_1 {
    struct PD_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PD_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PD_1>(arg0, 9, b"PD_1", b"Panda", x"f09f90bc20437574652050616e646120f09f90bc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ebf2337c-01e4-40db-a67e-c39801cd2a5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PD_1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PD_1>>(v1);
    }

    // decompiled from Move bytecode v6
}

