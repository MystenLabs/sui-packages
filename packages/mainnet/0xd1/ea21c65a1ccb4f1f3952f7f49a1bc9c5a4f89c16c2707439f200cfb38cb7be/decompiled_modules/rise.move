module 0xd1ea21c65a1ccb4f1f3952f7f49a1bc9c5a4f89c16c2707439f200cfb38cb7be::rise {
    struct RISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RISE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/QmS4stiFHjZa5ARJuVbqJTkNLXGq12Z37SZ3fTWSsouP2W                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RISE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RISE    ")))), trim_right(b"Warrior Rise                    "), trim_right(b"Warrior Rise (RISE) is a community token created by Nickole Galvan-Jenkins to promote autoimmune awareness, resilience, healing, advocacy, and hope. Built for those facing invisible battles. Not Weak. Just Warrior.                                                                                                          "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RISE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RISE>>(v4);
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

