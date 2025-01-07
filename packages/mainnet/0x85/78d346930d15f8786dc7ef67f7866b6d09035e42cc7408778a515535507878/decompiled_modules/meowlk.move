module 0x8578d346930d15f8786dc7ef67f7866b6d09035e42cc7408778a515535507878::meowlk {
    struct MEOWLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWLK>(arg0, 6, b"MEOWLK", b"MEOWLK", b"DRINK SOME MEOWLK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmaAF9uTKVwL5FhEjqoP6mNbxLi7jyWp2G7A7PWBx1zDPs")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<MEOWLK>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<MEOWLK>(5870463129266027550, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

