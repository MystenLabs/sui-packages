module 0x9c16f5c963cf8a9a955c34386b72227be4d979b7ff5bcfb9c6d6c434221e8f7b::hy {
    struct HY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HY>(arg0, 9, b"HY", b"Hi", b"Li", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a86fac4-9afa-44cc-add2-bb7b2987519b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HY>>(v1);
    }

    // decompiled from Move bytecode v6
}

