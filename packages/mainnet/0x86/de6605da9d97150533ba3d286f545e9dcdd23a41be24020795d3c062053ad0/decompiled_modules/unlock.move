module 0x86de6605da9d97150533ba3d286f545e9dcdd23a41be24020795d3c062053ad0::unlock {
    struct UNLOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNLOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FvxyJdeMwiSmqi9xXzqkDS1EgK8qtKn2Z6DRxE5Bpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<UNLOCK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"UNLOCK      ")))), trim_right(b"FREE THE MEMES                  "), trim_right(x"4556455259202431354b204d432c2031204d454d452057494c4c2042452052454c45415345442069732074686520636f6d6d756e697479207374726f6e6720656e6f75676820746f207361766520616c6c206f66207468656d3f20497320796f757220636f6e76696374696f6e207374726f6e6720656e6f75676820746f20686f6c6420746f2073617665207468656d3f0a0a4e6f205269736b732c204a757374204d656d657320616e6420546865205472656e636865732e0a49662074686520636f6d6d756e6974792069736e2774207374726f6e672c2074686520636f696e20776f6e2774206265207374726f6e672e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNLOCK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNLOCK>>(v4);
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

