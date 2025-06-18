module 0x374798cffe154158a41df50efc8f30eedf67aabda12615b1af29801413cb7ec4::dmc {
    struct DMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMC>(arg0, 6, b"DMC", b"DeLorean", b"Join us as we celebrate the legacy of innovation that the DeLorean brand embodies. This is the place to stay updated on all things DeLorean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif5fplzylzqvfz3yqdk3scy6sc3vnrnhrpo2f7yalvqkxafsfyd2u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DMC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

