module 0x73056a789ee70f43e46966d684563daaaa9f8a1b7083d5c69aa49d8bb40040b8::shh {
    struct SHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SHH>(arg0, 6, b"SHH", b"ha by SuiAI", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_1417_e6ade6b168.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

