module 0x6a472838c7b27c9fb9d170e465a68de69048d0b11070801a50fcc0f1ce0064d0::miharu {
    struct MIHARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIHARU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6tVZVjcppH2BZ9Xj5yFU1Zt34m2rYcyDqqpSeMDZpump.png?claimId=mdB9TCUJ0TMf-Hx4                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MIHARU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"miharu      ")))), trim_right(b"smiling dolphin                 "), trim_right(x"536d696c696e67204d6968617275206973206120636f6d6d756e6974792d64726976656e2070726f6a6563742064656469636174656420746f20737072656164696e6720706f73697469766974792e0a0a54686520746f6b656e20697320496e737069726564206279206120766972616c2070686f746f206f66204d69686172752c20612064656c6967687466756c206d616c652046696e6c65737320506f72706f6973652066726f6d204a6170616e2773204d6979616a696d6120417175617269756d2e200a0a4b65657020736d696c696e67212020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIHARU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIHARU>>(v4);
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

