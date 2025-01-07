module 0x11e8410d43284e812ae3aa97a23e8229b530005fbd2d78b76ab5606cd323b2ff::iwksj {
    struct IWKSJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: IWKSJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IWKSJ>(arg0, 9, b"IWKSJ", b"jemsn", b"bs income ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/befc8fa6-4ea4-4f98-a16e-f49f70977bf2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IWKSJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IWKSJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

