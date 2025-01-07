module 0xe5f1edd7e2ee580136bced58a1cba595d258e0ae15c1da772df01e09decdbe6e::ctrump {
    struct CTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTRUMP>(arg0, 6, b"cTrump", b"chinaTrump", b"Buy the Dip, Short the VIX, FUCK BITCOIN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/test_25b5f7a9d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

