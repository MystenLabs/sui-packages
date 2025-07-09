module 0x4f91e9e349286a9497905962ae251415052ee53f41ea82bae6d1d3cffd700138::gob {
    struct GOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3xypwTgs9nWgjc6nUBiHmMb36t2PwL3SwCZkEQvW8FTX.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GOB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GOB         ")))), trim_right(b"gob                             "), trim_right(x"24676f62206973206d6f7265207468616e20206a757374206120636f696e2e20200a0a546f6f20646f776e2062616420666f7220746865207472656e636865733f0a506c6179206f75722074726164696e672073696d756c61746f722053454c4c2054484520544f50206f6e2054696b746f6b20696e73746561642e0a0a4e4f205447210a436f6d706c61696e74733f2043616c6c207468652054656c65736372616d20486f746c696e652031202839353429203836392d34474f42202834343632292020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOB>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOB>>(v4);
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

