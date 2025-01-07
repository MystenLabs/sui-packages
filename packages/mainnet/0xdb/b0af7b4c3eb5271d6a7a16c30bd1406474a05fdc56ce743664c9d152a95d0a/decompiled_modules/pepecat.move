module 0xdbb0af7b4c3eb5271d6a7a16c30bd1406474a05fdc56ce743664c9d152a95d0a::pepecat {
    struct PEPECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPECAT>(arg0, 6, b"PEPECAT", b"Pepecat", x"546865206d656d65636f696e207468617420707572727320696e206861726d6f6e7920666f7220636174206c6f7665727320616e642066616e73206f66207468652069636f6e6963205065706521205768656e206d656d6520706f776572206d65657473206361742061646f726174696f6e2c207765206765742061204d656d65636f696e20206272696e6773206120736d696c6520746f206f75722066616365732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049637_e3f9b7e407.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

