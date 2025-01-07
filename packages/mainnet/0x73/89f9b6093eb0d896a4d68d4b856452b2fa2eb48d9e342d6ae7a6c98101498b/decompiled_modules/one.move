module 0x7389f9b6093eb0d896a4d68d4b856452b2fa2eb48d9e342d6ae7a6c98101498b::one {
    struct ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<ONE>(arg0, 5814170964591981315, b"1", b"1", b"1", b"https://images.hop.ag/ipfs/QmWwSxjn7NtrKauKhGBprkiUs5fN9x5edGqq2wKCciX8vZ", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

