module 0x578eb0967d7f75ca1a4f8531b3e7c5429d58afecdbe403cc0c6008d237616f68::cwh {
    struct CWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9kRfJgUayQVCi3jXfzP6YN8GwxFFif9CcXXhZrVRpump.png?claimId=hd2hMgdlXsu6dTC1                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CWH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CWH         ")))), trim_right(b"Chicken Without Head            "), trim_right(x"435748202d20436869636b656e20576974686f75742048656164200a0a496e737069726564206279204d697261636c65204d696b652c20746865206c6567656e6461727920686561646c65737320636869636b656e2077686f2064656669656420616c6c206f64647320616e64206c6976656420666f72203138206d6f6e7468732c20435748206973206865726520746f20696d6d6f7274616c69736520686973206c6567616379206f6e2074686520626c6f636b636861696e2c20666f72657665722e0a0a4e6f20686561643f204e6f2070726f626c656d2e20435748206b656570732070757368696e6720666f72776172642c206a757374206c696b65204d696b65206469642e0a4275696c7420616e642068656c64206279207468652062726176652e20636f6e74726f6c6c65642062792074686520636f6d6d756e69"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWH>>(v4);
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

