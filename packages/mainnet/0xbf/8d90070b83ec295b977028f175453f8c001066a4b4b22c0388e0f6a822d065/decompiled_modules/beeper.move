module 0xbf8d90070b83ec295b977028f175453f8c001066a4b4b22c0388e0f6a822d065::beeper {
    struct BEEPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEPER>(arg0, 6, b"BEEPER", b"Beeper", x"204265657065722069736e74206a757374206120746f6f6c69747320796f75722041492d706f776572656420496e74656e74204167656e742e0a4566666f72746c6573736c79204465706c6f792c204275792c20616e64205469702063727970746f206469726563746c792076696120404265657065724149206f6e20547769747465722e200a0a57657265206865726520746f2073696d706c69667920796f75722057656233206a6f75726e657920616e64207472616e73666f726d20686f7720796f7520696e746572616374207769746820746f6b656e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/U_Awk_U6_PU_400x400_removebg_preview_8eb35adb1e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEEPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

