module 0xeb24d393b2c602ad84b562fdb94c1f8c2b7f443d9dfddd5ff4d9283f61fe0ff8::littleguy {
    struct LITTLEGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LITTLEGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3Cmv9wxP1yNQZErQEFabB3L8uHxz49AtCRMrbKnBSozq.png?claimId=tAg_n87zWmU5ddMj                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LITTLEGUY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"littleguy   ")))), trim_right(b"just a little guy               "), trim_right(x"4064616e6b756e747a20697320746865206f6e6520626568696e64207468697320616d617a696e672074656b2c2077697468207468652069646561206f66206372656174696e6720746865206e6578742067656e206469676974616c20706574732c206263732068652062656c696576657320326b323520697320666f72207468652066756e210a0a4865206973206a7573742061206c6974746c652067757921202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LITTLEGUY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LITTLEGUY>>(v4);
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

