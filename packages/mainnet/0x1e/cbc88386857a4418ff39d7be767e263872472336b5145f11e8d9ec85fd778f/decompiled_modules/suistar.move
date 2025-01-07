module 0x1ecbc88386857a4418ff39d7be767e263872472336b5145f11e8d9ec85fd778f::suistar {
    struct SUISTAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTAR>(arg0, 6, b"SuiStar", b"We will shine", b"We will shin .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_17_24_34_ea360520e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISTAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

