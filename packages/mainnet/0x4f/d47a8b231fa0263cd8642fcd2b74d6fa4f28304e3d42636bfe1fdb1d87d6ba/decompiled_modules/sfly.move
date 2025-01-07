module 0x4fd47a8b231fa0263cd8642fcd2b74d6fa4f28304e3d42636bfe1fdb1d87d6ba::sfly {
    struct SFLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFLY>(arg0, 9, b"SFLY", b"SpaceFly", b"A fly coming from space and it will defeat all the coins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/866d1e5e-fea4-4dcc-aa40-159c0dcc6586.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

