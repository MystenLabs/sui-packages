module 0x764daa684acc3011a0d09ef1cdb8b81a82c0eb38b48980bfca5a6d304e3ea794::sgs {
    struct SGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGS>(arg0, 6, b"SGS", b"Scary Ghost", b"Join tg for more info ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1670_11d29f8afb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

