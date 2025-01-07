module 0xee8ce8189775e9faaefb5e122745ba3116adbeda654d73540b7c3e8373d66c9d::zwbrows {
    struct ZWBROWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZWBROWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZWBROWS>(arg0, 6, b"ZWBROWS", b"ZuckWitEyebrows", x"456c6f6e204d75636b20736861726564206120706f737420776865726520736f6d656f6e65206164646564202745796562726f772720746f207a75636b657262657267210a4c657427732063656c6562726174652074686973206d6f6d656e74210a536f2c2049742773205a5742524f570a68747470733a2f2f782e636f6d2f656c6f6e6d75736b2f7374617475732f313833373931323833393935303034353537340a53656e6420245a5742524f5720746f204d617273210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fgdsfgsdgd_5692df723b.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZWBROWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZWBROWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

