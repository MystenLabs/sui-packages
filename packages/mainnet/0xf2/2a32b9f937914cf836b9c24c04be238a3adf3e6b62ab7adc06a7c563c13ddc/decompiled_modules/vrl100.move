module 0xf22a32b9f937914cf836b9c24c04be238a3adf3e6b62ab7adc06a7c563c13ddc::vrl100 {
    struct VRL100 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VRL100, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9qWrqckQjqfYvMNsSVQotAqCabroyt7uPAKoRhVVPvxw.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VRL100>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VRL100      ")))), trim_right(b"VIRAL100                        "), trim_right(x"2456524c313030207c204e6f20666c7566662e204e6f2042532e204a757374206f6e65206d697373696f6e202d20313030580a576520626f6f7374202b20596f7520626f6f73742e20546f6765746865722077652073656e642069742e200a466f722074686520756e646572646f67732c2074686520646567656e732c20746865206d6973666974732e20476f6c64656e207469636b6572206f6e20446578202d6c657473676f564952414c2e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VRL100>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VRL100>>(v4);
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

