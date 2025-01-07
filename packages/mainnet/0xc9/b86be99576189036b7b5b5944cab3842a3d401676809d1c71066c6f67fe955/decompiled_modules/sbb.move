module 0xc9b86be99576189036b7b5b5944cab3842a3d401676809d1c71066c6f67fe955::sbb {
    struct SBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBB>(arg0, 6, b"SBB", b"Sui Bridge Bot", b"Bridge from any chain to SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241005_134323_019_5386ede041.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

