module 0xb48f299ee0e84dfba418b076d376b2c4e30e7317e4e0997cd8d1c7fe82f8b2d::fdh {
    struct FDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDH>(arg0, 9, b"FDH", b"VGDS", b"BF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/364aee62-774e-4f4c-acd1-604456bfc9f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FDH>>(v1);
    }

    // decompiled from Move bytecode v6
}

