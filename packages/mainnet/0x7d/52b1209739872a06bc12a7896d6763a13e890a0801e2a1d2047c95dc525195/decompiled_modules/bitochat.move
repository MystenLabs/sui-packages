module 0x7d52b1209739872a06bc12a7896d6763a13e890a0801e2a1d2047c95dc525195::bitochat {
    struct BITOCHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITOCHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITOCHAT>(arg0, 8, b"bitoCHAT.sui", b"bito wrapped chat", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cbi-website-material.s3.us-east-1.amazonaws.com/icp_logo/chat.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITOCHAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITOCHAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

