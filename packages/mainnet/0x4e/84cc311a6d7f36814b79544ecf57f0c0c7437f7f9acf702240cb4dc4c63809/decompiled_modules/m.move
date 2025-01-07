module 0x4e84cc311a6d7f36814b79544ecf57f0c0c7437f7f9acf702240cb4dc4c63809::m {
    struct M has drop {
        dummy_field: bool,
    }

    fun init(arg0: M, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M>(arg0, 9, b"M", b"MEWTT", b"MewTT on the moutain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c1204f39-656b-4ca0-bf67-482837e4be7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M>>(v1);
    }

    // decompiled from Move bytecode v6
}

