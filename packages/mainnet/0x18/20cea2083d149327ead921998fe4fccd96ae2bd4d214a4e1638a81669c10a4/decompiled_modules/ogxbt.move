module 0x1820cea2083d149327ead921998fe4fccd96ae2bd4d214a4e1638a81669c10a4::ogxbt {
    struct OGXBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGXBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OGXBT>(arg0, 6, b"OGXBT", b"Ogxbt by SuiAI", b"The first ai agent on Sui which workes on both @openai and @ai16zdao nodes..Dev is ogxbt verify in channel of telegram ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_1753_b3f9ff9fa2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OGXBT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGXBT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

