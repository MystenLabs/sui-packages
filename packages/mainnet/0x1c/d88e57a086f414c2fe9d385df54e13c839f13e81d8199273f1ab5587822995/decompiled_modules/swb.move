module 0x1cd88e57a086f414c2fe9d385df54e13c839f13e81d8199273f1ab5587822995::swb {
    struct SWB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWB>(arg0, 6, b"SWB", b"SuiWalletBot", x"53756957616c6c6574426f742069732053756957616c6c6574204170706c69636174696f6e206f6e2054656c656772616d20426f74200a68747470733a2f2f742e6d652f53756957616c6c6574426f745f626f74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/water_drop2568_logowik_com_c284d62382.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWB>>(v1);
    }

    // decompiled from Move bytecode v6
}

