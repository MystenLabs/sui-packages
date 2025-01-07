module 0xf3b5f834d362d9d1b0094bfdd46b5f501fb468382ac03a65306a3d201e631292::broski {
    struct BROSKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROSKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROSKI>(arg0, 6, b"BROSKI", b"BROSKI ON SUI", b"FIRST BROSKI ON SUI: https://broskionsui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_39_48e848e600.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROSKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROSKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

