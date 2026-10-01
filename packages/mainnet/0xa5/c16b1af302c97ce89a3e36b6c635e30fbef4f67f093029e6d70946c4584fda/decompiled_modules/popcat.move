module 0xa5c16b1af302c97ce89a3e36b6c635e30fbef4f67f093029e6d70946c4584fda::popcat {
    struct POPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<POPCAT>(arg0, 6, 0x1::string::utf8(b"POPCAT"), 0x1::string::utf8(b"Popcat"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://popularsui.xyz/media/fce4f5014fb9a296ac4f0face1082982d3dac6b8ed548b2084021a1505ea3ea8.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPCAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<POPCAT>>(0x2::coin_registry::finalize<POPCAT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

