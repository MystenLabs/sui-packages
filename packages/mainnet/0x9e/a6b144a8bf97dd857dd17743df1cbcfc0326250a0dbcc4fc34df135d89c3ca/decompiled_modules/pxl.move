module 0x9ea6b144a8bf97dd857dd17743df1cbcfc0326250a0dbcc4fc34df135d89c3ca::pxl {
    struct PXL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PXL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PXL>(arg0, 6, b"PXL", b"PIXSUI", b"Unleash your creativity in the vibrant, decentralized world of PIXSUI, the ultimate pixel art universe built on the lightning-fast Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_be3fdafcac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PXL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PXL>>(v1);
    }

    // decompiled from Move bytecode v6
}

