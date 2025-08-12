module 0xa9759d5a57243dec59970242185a5aefe6be7b756bf4f3f01f5e0bb8c4c3004a::littlebuck {
    struct LITTLEBUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LITTLEBUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/G2ajLzpiW6tPvRqdjz6QfFKyArrh7zh66Zi1rmoppump.png?claimId=QmJs0BGpRnu7vniE                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LITTLEBUCK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LittleBuck  ")))), trim_right(b"Little Buck the deer            "), trim_right(x"486f6e6f72696e67204c6974746c65204275636b200a42656c6f7665642066616d696c7920646565722077726f6e6766756c6c792074616b656e2066726f6d2068697320686f6d652e0a4669676874696e6720666f72206a7573746963652c206368616e676520262061776172656e6573732e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LITTLEBUCK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LITTLEBUCK>>(v4);
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

