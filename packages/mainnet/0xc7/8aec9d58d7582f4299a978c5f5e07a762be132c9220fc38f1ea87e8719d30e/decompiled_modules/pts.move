module 0xc78aec9d58d7582f4299a978c5f5e07a762be132c9220fc38f1ea87e8719d30e::pts {
    struct PTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/6Uh9OSWl6M7Yp0qNDWhtjgFMHmfDEf04msz8FT84ztg";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/6Uh9OSWl6M7Yp0qNDWhtjgFMHmfDEf04msz8FT84ztg"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<PTS>(arg0, 9, trim_right(b"PTS"), trim_right(b"PandaTools"), trim_right(b"PandaTools is token creation tool"), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTS>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PTS>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTS>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

