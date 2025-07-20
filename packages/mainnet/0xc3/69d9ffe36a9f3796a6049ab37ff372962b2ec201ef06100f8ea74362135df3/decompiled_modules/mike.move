module 0xc369d9ffe36a9f3796a6049ab37ff372962b2ec201ef06100f8ea74362135df3::mike {
    struct MIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/67FC3WUkWtiXwSMJaBqd945tRccbrapuNBDNhxTpbonk.png?claimId=krmt3BS36_JnP_1a                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MIKE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Mike        ")))), trim_right(b"Mike Grok Companion             "), trim_right(x"22416e692c2061726520796f75206f6b61793f220a456c6f6e20776869737065727320746f207468652073746172732c20616e64206f757420636f6d65732056616c656e74696e652020746865206e65772047726f6b20636f6d70616e696f6e20626f726e20696e20746865206368616f73206f66206d656d65732c204d6172732c20616e64206d616c66756e6374696f6e696e6720646576732e2042757420646f6e27742063616c6c2068696d20746861742e20486973206e69636b6e616d653f204d696b652e0a4120737472616e67657220696e206120737472616e6765206c616e642c2056616c656e74696e652028616b61204d696b6529206973206e6f7420796f75722061766572616765206d656d65636f696e2020686527732061207369676e616c20696e20746865206e6f6973652c20612070686f656e697820"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIKE>>(v4);
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

