module 0x76fd14384039e99b165108d83b3a6707e31566089cda05634569c57b06bceedd::suish {
    struct SUISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISH>(arg0, 6, b"SUISH", b"Suish on Sui", b"SUISH is a lifestyle meme on sui, with an ethos of confidence, winning and celebrating. Join us now on telegram, follow on X, and join the cult of winners. - Just Pump it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suish_5ba190905e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

