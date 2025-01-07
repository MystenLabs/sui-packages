module 0xa8bfbcfce637efee341fa9822ea6fd4eed897e91a10511d2984439a0098ff4f8::smart {
    struct SMART has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMART>(arg0, 6, b"SMART", b"SUI ART", x"3132306b20666f72207468697320617274206f72203132306b206d61726b657420636170206d656d652e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sold_7848414795.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMART>>(v1);
    }

    // decompiled from Move bytecode v6
}

