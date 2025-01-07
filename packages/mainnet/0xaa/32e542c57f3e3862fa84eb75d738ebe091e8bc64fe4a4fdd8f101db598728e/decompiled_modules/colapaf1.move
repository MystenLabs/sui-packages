module 0xaa32e542c57f3e3862fa84eb75d738ebe091e8bc64fe4a4fdd8f101db598728e::colapaf1 {
    struct COLAPAF1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLAPAF1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLAPAF1>(arg0, 6, b"ColapaF1", b"F1Turbo", b"This token represents Franco and his well-deserved achievement, this will be the fastest meme, we will win the race without stops!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731478693467.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COLAPAF1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLAPAF1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

