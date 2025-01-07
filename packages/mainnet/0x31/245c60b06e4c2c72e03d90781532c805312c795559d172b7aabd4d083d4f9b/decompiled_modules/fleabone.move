module 0x31245c60b06e4c2c72e03d90781532c805312c795559d172b7aabd4d083d4f9b::fleabone {
    struct FLEABONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLEABONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLEABONE>(arg0, 6, b"FLEABONE", b"FLEABONE SUI", x"686520627265616b64616e63696e6720646f672066726f6d204d61747420467572696573206c6f6e672d6c6f7374207476200a0a636172746f6f6e2070696c6f742022446f626c652046726965642220", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_41_19f4bfe00b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLEABONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLEABONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

