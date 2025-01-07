module 0x8a7bf86dfb75883a184c8cbc3ab8297363d15dfba7bad2f73b12ff22c65b46ff::dogs {
    struct DOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGS>(arg0, 6, b"DOGs", b"DOGs IN OCEAN", x"487920446f47732e2e0a4861707079206c69666520696e204f6365616e202066756c6c7920736e61636b207769746820537569666973682e2e0a6275696c6420696e205375690a47726f777468207769746820796f75", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_dfd1da8789.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

