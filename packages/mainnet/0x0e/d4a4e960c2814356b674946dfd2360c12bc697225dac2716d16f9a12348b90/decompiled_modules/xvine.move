module 0xed4a4e960c2814356b674946dfd2360c12bc697225dac2716d16f9a12348b90::xvine {
    struct XVINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: XVINE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CN2G2H8vvLgHxDo9SDb5SJsdTDvC2tD9fZpEdqsnpump.png?claimId=ln7kGTz-c1E5s5Zx                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<XVINE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"XVine       ")))), trim_right(b"X Vine                          "), trim_right(x"5468697320697320746865206669727374205856696e6520736f207765206465636964656420776520776f756c642072756e20697420626574746572207468616e20616e796f6e6520656c73652e0a0a57657265206578636974656420746f2074616b656f766572207468652072656269727468206f662056696e65206173205856696e652c20726973696e672066726f6d2074686520617368657320776974682074686520737570706f7274206f6620456c6f6e2e0a0a4e6f772c205856696e65206973206865726520746f20726569676e697465207468617420737061726b2e20546869732070726f6a6563742069732064656469636174656420746f2074686520626561757479206f66206372656174696f6e20616e6420636f6d6d756e6974790a0a536861726520796f7572206661766f726974652056696e65206d"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XVINE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XVINE>>(v4);
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

