module 0x3d1781c171837b6e8154d0bbf783565045f925812ed6505a6da7006ef083890a::beast {
    struct BEAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAST>(arg0, 6, b"BEAST", b"BEAST SUI", b"FIRST BEAST ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OV_Yv_Al3_H_400x400_ede2198408.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

