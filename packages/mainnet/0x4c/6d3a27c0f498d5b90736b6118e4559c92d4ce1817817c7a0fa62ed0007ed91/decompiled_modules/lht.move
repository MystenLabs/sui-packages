module 0x4c6d3a27c0f498d5b90736b6118e4559c92d4ce1817817c7a0fa62ed0007ed91::lht {
    struct LHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LHT>(arg0, 9, b"LHT", b"LHT CHANNE", b"Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/afac93f3-2320-4f22-8c22-2508b21e6eab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

