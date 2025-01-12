module 0x8a03c6303b3bec0012d8bfd034854fc375c61b0c2276571648b32241f47098fb::taic {
    struct TAIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TAIC>(arg0, 6, b"TAIC", b"Thomas AI by SuiAI", b"My name is Thomas, I will answer all of your questions. Just for AI fun! .Dev (me) put only 3000 SUAI into this coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_4352_ccb6b0fc82.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TAIC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAIC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

