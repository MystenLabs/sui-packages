module 0x7115224fe849991300b25751d5b43bc505f35e8076c0ac9c538e418853c11fd::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSS>(arg0, 6, b"SSS", b"Sea Slug Species", x"5469636b657220666f204465536369202d20536369656e7469737473206861766520646973636f7665726564207468652066697273742073656120736c756720737065636965732074686174206c6976657320696e20746865206f6365616ee2809973207477696c69676874207a6f6e652e0a0a556e6c696b65206f74686572206e7564696272616e6368732c2074686973206f6e65207377696d73e280947573696e67206120666c6f70707920686f6f6420736861706564206c696b65206120666f67686f726e20746f2073686f6f74207761746572206a657473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731853333782.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

