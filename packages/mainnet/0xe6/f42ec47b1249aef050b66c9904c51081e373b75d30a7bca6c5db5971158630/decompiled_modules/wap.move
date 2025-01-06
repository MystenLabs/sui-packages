module 0xe6f42ec47b1249aef050b66c9904c51081e373b75d30a7bca6c5db5971158630::wap {
    struct WAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WAP>(arg0, 6, b"WAP", b"Wet Ass Pussy by SuiAI", b"NOTHING BETTER THAN A WET ASS PUSSY ON THE WATER CHAIN, DO IT FOR YOURSELF NOT YOUR GIRL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/WAP_350e621e2e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

