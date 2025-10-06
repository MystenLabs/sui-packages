module 0xd46349e3ade2b82c8e6c43f7231bc05b3a7779571e8215330df62778c810db51::way {
    struct WAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/QmQV1dEXzbRuKVMmtoff4KoSq1nzaKbRcHXM7qypjr6fDB                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WAY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WAY     ")))), trim_right(b"The Way Community Token         "), trim_right(x"5468652057617920436f6d6d756e69747920546f6b656e202824574159292069732061206772617373726f6f74732070726f6a65637420666f6375736564206f6e206275696c64696e672072656e74616c2070726f706572746965732066726f6d207468652067726f756e6420757020696e20736d616c6c20636f6d6d756e69746965732c207374617274696e6720696e20526f6262696e732c20494c2e0a52656e742077696c6c206265207061696420696e20535741592c20616e6420617320737570706f72742067726f77732c206e65772070726f706572746965732077696c6c206265206275696c742e2046757475726520746f6b656e20686f6c646572732077696c6c206561726e20696e63656e746976657320616e64206f776e65727368697020696e20636f6d6d756e69747920646576656c6f706d656e74732e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAY>>(v4);
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

