module 0xd493640714f5d40689ef6daaac506111ec21f4578ff53e765242295f0f1a1cb7::pxs {
    struct PXS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PXS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PXS>(arg0, 6, b"PXS", b"PHANTOM X SUI COIN", b"PHANTOM X SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_pxs1_7de4a6bb09.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PXS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PXS>>(v1);
    }

    // decompiled from Move bytecode v6
}

