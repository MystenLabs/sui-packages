module 0x1dfc11521f9a41a840bea1fc5cbc9de59dbd7445d8b755e23758225e80c40f6e::hello7 {
    struct HELLO7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO7>(arg0, 6, b"Hello7", b"hello", b"I call you, you dare answer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730894975738.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLO7>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO7>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

