module 0xcb162fd847d90488f78b70d446363725d4df6f9276ebdd0be80d9d4d8b2137cc::loco {
    struct LOCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCO>(arg0, 6, b"LOCO", b"LocoWifCoco", b"Come get Loco wif Coco! locowifcoco.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dfc_ax_Ch_400x400_5bcc9f7f72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

