module 0xf3c2a74b89b7d8a3850fd1076ebc571949d38de5d06fa0a4510d163593986dba::bison {
    struct BISON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BISON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/wUofF4kJhpmZ7c4h1kWR9FAdz48JiLF5VfGbpn5pump.png?claimId=P_-t2xQnjYYGL2QL                                                                                                                                                                                                       ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BISON>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BISON       ")))), trim_right(b"American Bison                  "), trim_right(x"54686520416d65726963616e20244249534f4e206973206f6e65206f66207468652074776f206e6174696f6e616c20616e696d616c73206f662074686520556e697465642053746174657320616e64207761732064657369676e6174656420617320746865206e6174696f6e616c206d616d6d616c20696e20323031362e0a0a4c657473206272696e67206261636b207468652062756c6c20210a0a43544f2120202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BISON>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BISON>>(v4);
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

