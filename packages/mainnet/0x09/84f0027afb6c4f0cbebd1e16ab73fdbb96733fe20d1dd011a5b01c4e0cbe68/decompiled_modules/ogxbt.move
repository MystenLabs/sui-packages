module 0x984f0027afb6c4f0cbebd1e16ab73fdbb96733fe20d1dd011a5b01c4e0cbe68::ogxbt {
    struct OGXBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGXBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OGXBT>(arg0, 6, b"OGXBT", b"Ogxbt by SuiAI", b"The first ai agent powered by @openai and @ai16zdao codes ..Dev is og.eth you can join his tg channel for more information ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_1753_ac9e3ec3c6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OGXBT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGXBT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

