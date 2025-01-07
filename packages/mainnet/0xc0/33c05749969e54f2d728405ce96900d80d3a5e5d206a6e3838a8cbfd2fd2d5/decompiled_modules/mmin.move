module 0xc033c05749969e54f2d728405ce96900d80d3a5e5d206a6e3838a8cbfd2fd2d5::mmin {
    struct MMIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMIN>(arg0, 9, b"MMIN", b"MiniMin", b"Mini", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc8aec91-a69c-44c7-bef4-e249ea0e94e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

