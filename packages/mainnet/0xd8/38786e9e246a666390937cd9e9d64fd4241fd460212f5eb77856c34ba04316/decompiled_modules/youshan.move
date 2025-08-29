module 0xd838786e9e246a666390937cd9e9d64fd4241fd460212f5eb77856c34ba04316::youshan {
    struct YOUSHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOUSHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8WZs63wKVQg9DcaWCDyrZ26ED93bnTc1pHrx7Es8pump.png?claimId=RZGcjvrgH-jIThuK                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<YOUSHAN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"YOUSHAN     ")))), trim_right(b"HOMUNCULUS DOG                  "), trim_right(x"54686973206d656d652063616d652066726f6d2070757265206f70746963616c20696c6c7573696f6e206f66206120646f67207769746820666c75666679206675722c207768617420636f756c6420626520626574746572207468616e20746869733f200a596f757368616e206973207375636820612063757469652c20746865206b696e64206f6620646f67207468617420646f65736e74206576656e206e65656420746f207472792e204a7573742073697474696e67207468657265206c6f6f6b696e67206c696b65206120666c75666679206c6974746c652062616c6c2077697468206f6e65206269672065796520696c6c7573696f6e20616e6420616c726561647920737465616c696e67207468652077686f6c6520696e7465726e6574732068656172742e20202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOUSHAN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOUSHAN>>(v4);
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

