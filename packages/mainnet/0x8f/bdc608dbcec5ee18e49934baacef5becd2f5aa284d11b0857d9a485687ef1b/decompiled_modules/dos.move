module 0x8fbdc608dbcec5ee18e49934baacef5becd2f5aa284d11b0857d9a485687ef1b::dos {
    struct DOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOS>(arg0, 6, b"DOS", b"DogsOnSui", b"Dogs together strong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmT2M1dW8UfUJjxi8WZGD7w1FTzJnVekDSTKcuTjXFqEUe")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<DOS>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<DOS>(15469415738085773944, v0, v1, 0x1::string::utf8(b"https://x.com/DogssOnSui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"http://t.me/sui_doss"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

