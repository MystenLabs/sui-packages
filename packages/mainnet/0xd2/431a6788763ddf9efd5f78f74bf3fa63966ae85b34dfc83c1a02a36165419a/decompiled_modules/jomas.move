module 0xd2431a6788763ddf9efd5f78f74bf3fa63966ae85b34dfc83c1a02a36165419a::jomas {
    struct JOMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOMAS>(arg0, 6, b"JOMAS", b"JOMASHOP", b"TOKEN FOR JOMASHOP.COM ECONOMIC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/JOMASHOP_c4512e929c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

