module 0x295e4ab945bee50fcb88404a876f1c6ef31ce34f4953fbd1689b748607840e01::l2 {
    struct L2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: L2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L2>(arg0, 9, b"L2", b"Layer2", b"https://x.com/layer2airdrops?t=2DGNe6xo0np_XxMGNJm_Bg&s=09", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7473a247-ea78-43aa-9d60-84249138d4d1-1000102617.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<L2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L2>>(v1);
    }

    // decompiled from Move bytecode v6
}

