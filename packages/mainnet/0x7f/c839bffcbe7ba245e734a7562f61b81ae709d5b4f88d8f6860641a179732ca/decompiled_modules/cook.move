module 0x7fc839bffcbe7ba245e734a7562f61b81ae709d5b4f88d8f6860641a179732ca::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOK>(arg0, 6, b"COOK", b"COOK AI", x"434f4f4b204149206372656174657320756e697175652072656369706573206261736564206f6e20757365722d73656c656374656420696e6772656469656e747320616e64206469657461727920707265666572656e6365730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cook_35b1186443.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

