module 0x1c7c16e1fe00a414e93e7f233c1acfe748e5c106f10dcc779313c92234cc2475::poncho {
    struct PONCHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONCHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONCHO>(arg0, 6, b"PONCHO", b"Poncho sui", x"4d656d65636f696e206261736564206f6e2061206361742077656172696e67206120706f6e63686f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/poncho_sui_3517602665.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONCHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONCHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

