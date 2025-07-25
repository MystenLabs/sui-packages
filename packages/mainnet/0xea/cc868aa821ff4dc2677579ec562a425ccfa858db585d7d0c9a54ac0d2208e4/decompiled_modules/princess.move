module 0xeacc868aa821ff4dc2677579ec562a425ccfa858db585d7d0c9a54ac0d2208e4::princess {
    struct PRINCESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRINCESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRINCESS>(arg0, 6, b"Princess", b"Princess SUI", x"5072696e6365737320535549206973206120756e69717565206d656d65636f696e20666561747572696e67206120717569726b792041492d67656e6572617465642062616c6c6572696e61207769746820612063617070756363696e6f20686561642e204275696c74206f6e20537569e280997320666173742c206c6f772d636f7374206e6574776f726b2c206974e28099732064657369676e656420666f7220736d6f6f74682074726164696e6720616e6420636f6d6d756e69747920656e676167656d656e742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753464746166.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRINCESS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRINCESS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

