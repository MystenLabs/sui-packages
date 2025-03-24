module 0xe7e744cd9dc885a5af34b412d6aa3d2a1024c15dadf52a6e6f665c17bd18cccb::fuckit {
    struct FUCKIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Cc9w93qDEQJ8mxPcvKy1cDVDJQbL6bFt9bUKdi57pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FUCKIT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"fuckit      ")))), trim_right(b"fuck it.                        "), trim_right(x"5469726564206f66206f7665727468696e6b696e672065766572792074726164653f205369636b206f66206368617274732c20616e616c797369732c20616e64207574696c6974793f2057656c636f6d6520746f204675636b20497420436f696e2c20746865206d656d6520636f696e20666f722065766572796f6e652077686f732065766572207468726f776e2074686569722068616e647320757020616e6420736169642077656c6c2c20796f75206b6e6f772e200a0a246675636b69742069736e74206a757374206120636f696e2c2069747320612077686f6c652064616d6e206d6f6f642e20497427732074686520616e7468656d20666f7220646567656e732c20647265616d6572732c20616e64206d6973666974732077686f206b6e6f77207468617420736f6d6574696d657320796f75206a75737420676f74"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKIT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCKIT>>(v4);
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

