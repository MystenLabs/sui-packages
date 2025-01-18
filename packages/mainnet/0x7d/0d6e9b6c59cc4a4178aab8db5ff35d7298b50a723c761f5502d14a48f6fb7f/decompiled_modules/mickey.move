module 0x7d0d6e9b6c59cc4a4178aab8db5ff35d7298b50a723c761f5502d14a48f6fb7f::mickey {
    struct MICKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MICKEY>(arg0, 6, b"MICKEY", b"MICKEY ON SUIAI by SuiAI", b"$MICKEY WILL BE THE NEXT BIG MEME COIN ON SUIAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Simple_Logo_crypto_coin_with_Mickey_inside_no_b_d0fe59a471.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MICKEY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICKEY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

