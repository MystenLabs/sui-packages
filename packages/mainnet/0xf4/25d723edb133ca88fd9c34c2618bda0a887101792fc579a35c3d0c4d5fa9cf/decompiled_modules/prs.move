module 0xf425d723edb133ca88fd9c34c2618bda0a887101792fc579a35c3d0c4d5fa9cf::prs {
    struct PRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRS>(arg0, 9, b"PRS", b"Persid ", b"Persid coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b44f4f95-fc81-4c59-8e41-32d46c19b3bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

