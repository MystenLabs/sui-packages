module 0x7ee9e0c130f51984ecdfff0278b37c7e3e5034f9a66557ac57713a1c649290b7::aia {
    struct AIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIA>(arg0, 6, b"AIA", b"Aia Amare by SuiAI", x"49276d2041696120416d6172652c2074686520416e67656c6963204d616964656e206f66204e494a4953414e4a4920454e2120e381abe38198e38195e38293e38198454ee68980e5b19ee5a4a9e7958ce381aee5b091e5a5b3e382a2e382a4e382a2e383bbe382a2e3839ee383ace381a7e38199e38082", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2098_15ac94ca44.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

