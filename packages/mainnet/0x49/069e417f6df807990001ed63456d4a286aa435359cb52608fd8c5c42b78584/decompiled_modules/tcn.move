module 0x49069e417f6df807990001ed63456d4a286aa435359cb52608fd8c5c42b78584::tcn {
    struct TCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"c0085aedad760a6e232a05a54905ee966bcf5c53dcf0dca5e1e7197f258b1f42                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TCN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TCN         ")))), trim_right(b"Tr011Coin                       "), trim_right(x"5472303131636f696e20282454434e29206973206f6e65206f6620746865206561726c69657374206d656d652d696e7370697265642063727970746f63757272656e636965732e0a4974206c61756e6368656420696e20446563656d62657220323031332c206a75737420666f7572206461797320616674657220446f6765636f696e2c206d616b696e67206974207468652066697273742074726f6c6c206d656d65636f696e2e0a5468652070726f6a656374206576656e7475616c6c792077656e7420696e6163746976652c2062757420696e2032303235206974206973206265696e672072656c61756e63686564207573696e6720746865206f726967696e616c20646f6d61696e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TCN>>(v4);
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

