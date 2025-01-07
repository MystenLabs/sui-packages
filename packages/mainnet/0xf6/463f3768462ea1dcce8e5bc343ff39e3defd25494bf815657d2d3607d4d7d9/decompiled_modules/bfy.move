module 0xf6463f3768462ea1dcce8e5bc343ff39e3defd25494bf815657d2d3607d4d7d9::bfy {
    struct BFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFY>(arg0, 9, b"BFY", b"baterfly", b"The butterfly makes you fly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/40b3ceb7-be65-4396-91ed-cbbfb7e9ebf5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

