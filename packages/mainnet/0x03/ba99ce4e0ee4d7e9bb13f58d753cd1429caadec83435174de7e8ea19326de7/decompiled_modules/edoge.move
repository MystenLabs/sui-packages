module 0x3ba99ce4e0ee4d7e9bb13f58d753cd1429caadec83435174de7e8ea19326de7::edoge {
    struct EDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDOGE>(arg0, 6, b"EDOGE", b"EDOGES", b"Satoshi Nakamoto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016500_32a166fc3d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

