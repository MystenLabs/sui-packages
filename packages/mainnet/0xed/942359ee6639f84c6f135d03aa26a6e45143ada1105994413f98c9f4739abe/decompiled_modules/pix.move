module 0xed942359ee6639f84c6f135d03aa26a6e45143ada1105994413f98c9f4739abe::pix {
    struct PIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIX>(arg0, 6, b"PIX", b"PIXSUIL", b"PIXSUIL, the mascot of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_183827_54846ca0ad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

