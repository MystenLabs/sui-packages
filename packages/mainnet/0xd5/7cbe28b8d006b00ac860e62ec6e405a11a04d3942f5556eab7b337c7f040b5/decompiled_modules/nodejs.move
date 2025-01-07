module 0xd57cbe28b8d006b00ac860e62ec6e405a11a04d3942f5556eab7b337c7f040b5::nodejs {
    struct NODEJS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NODEJS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NODEJS>(arg0, 6, b"NODEJS", b"node.js", b"Node.js is the best script language instead of PHP and python. I'm absolutely sure it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WX_20241126_142355_2x_4a4fd218f3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NODEJS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NODEJS>>(v1);
    }

    // decompiled from Move bytecode v6
}

