module 0xc49f59266b66fd7b653b953f3bd4c57eb7b6e8b5b7cced99007c713f1e4775f1::wshiba {
    struct WSHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSHIBA>(arg0, 6, b"Wshiba", b"Water Shiba", b"Water Shiba ready to Deep in into Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaaaashib_5e3be93dca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

