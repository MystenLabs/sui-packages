module 0xc9a81106799092192c10d36fe69aa309b975bdf3984d7e11d715c7161c2926c8::vanilla {
    struct VANILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VANILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"11          ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/QmeG1ZvVHHeyEcWNpd6DeP1fuctoyhqpYVvSFnf4B5Z38F                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VANILLA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Vanilla ")))), trim_right(b"Vanilla Rice's Hibachi House    "), trim_right(b"Vanilla Rice's Hibachi House Coin                                                                                                                                                                                                                                                                                               "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VANILLA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VANILLA>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

