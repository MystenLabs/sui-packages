module 0xc1291eb7a0832e3a3136f0959b9c5a9a4aca0c622d2e13b8a00a4665f38e7f11::hellish {
    struct HELLISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLISH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GYcxF4bbzNBV4GhzbfAG1im1kjnRpE5R9xiD523czf5Y.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HELLISH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"hellish     ")))), trim_right(b"devils                          "), trim_right(x"426f726e2066726f6d207468652061627973732c2048656c6c697368436f696e20282444454d4f4e292069732074686520756c74696d617465206d656d65636f696e20666f7220646567656e732077686f206c696b6520697420686f742e204120666972652d6675656c656420746f6b656e20726964696e67207761766573206f66206368616f732c20687970652c20616e64207075726520696e6665726e6f20656e657267792e0a4e6f20726f61646d61702e204e6f206d657263792e204a75737420666c616d65732e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLISH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELLISH>>(v4);
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

