module 0xe654db3cf9cac4ba42defa60b755d6b4cab8ca5d7cf80ff00ce3336f8f7a2a57::alerts {
    struct ALERTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALERTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALERTS>(arg0, 6, b"ALERTS", b"SUI Alerts", x"47657420416c6572747320666f7220646966666572656e7420626c6f636b636861696e206576656e7473206f6e205355490a2d20566f6c756d6520416c657274730a2d204e657720546f6b656e204465706c6f797320416c657274730a2d205768616c6520707572636861736520416c657274730a2d204d6f766570756d7020416c657274730a0a416e64206d6f72652e2e2e20416c6c206f6e2054470a68747470733a2f2f742e6d652f6164646c6973742f5f685441303572757761557a4e7a4930", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/botpic_751a34517e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALERTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALERTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

