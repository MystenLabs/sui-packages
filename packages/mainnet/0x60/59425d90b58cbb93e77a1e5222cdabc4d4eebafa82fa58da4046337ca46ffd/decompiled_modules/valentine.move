module 0x6059425d90b58cbb93e77a1e5222cdabc4d4eebafa82fa58da4046337ca46ffd::valentine {
    struct VALENTINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VALENTINE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/747LA9GT7DFzTPJnuZuPJu4jydWnbxZxiaoaG1tpBaSu.png?claimId=Cvw5aEeNH1XP00Zw                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VALENTINE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VALENTINE   ")))), trim_right(b"Valentine's Day                 "), trim_right(x"4865726520746f20626520796f7572202456414c454e54494e45200a0a48617665206e6f2056616c656e74696e65206265636175736520796f75277265206120646567656e6572617465207472616465723f204f72206c6f6f6b696e6720746f2066696e616c6c79206265636f6d652070726f66697461626c6520746f206275792068657220746861742056616c656e74696e657320676966743f2057656c6c2077656c636f6d6520746f20746865206f6666696369616c20636f696e206f662056616c656e74696e657320446179206f6e20536f6c616e612c206865726520746f20626520796f7572202456414c454e54494e452e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VALENTINE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VALENTINE>>(v4);
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

