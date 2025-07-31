module 0x866eec5ad0914be9b9ad7bfd9ad5dfe92fd8b017d62e7ad7419b53a2dd8aae02::squeeze {
    struct SQUEEZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUEEZE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AmSLebuF5rPu1GeWswy9TV5baQtQzKVsGGrK5raEbunt.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SQUEEZE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Squeeze     ")))), trim_right(b"Squeeze Coin                    "), trim_right(x"2453717565657a65206973206e6f74206c696b65206576657279206f746865722073686974636f696e2e205468697320636f696e206973206d617468656d61746963616c6c79206261636b656420746f206361757365206120737570706c792073717565657a652073696d696c617220746f207468652073686f72742073717565657a652074686174206f63637572726564206f6e2024474d4520696e20323032312e0a0a4062756e7466756e0a206a75737420676f74206c697374656420617320616e206f6666696369616c206c61756e63687061642c20627574207468657265277320736f6d657468696e672061206c6974746c6520646966666572656e742061626f757420746865697220706c6174666f726d2e202043726561746f72207265776172647320617265206d75636820686967686572207468616e207765"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUEEZE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUEEZE>>(v4);
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

