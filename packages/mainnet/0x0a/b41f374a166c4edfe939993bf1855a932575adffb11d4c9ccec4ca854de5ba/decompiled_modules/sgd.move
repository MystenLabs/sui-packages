module 0xab41f374a166c4edfe939993bf1855a932575adffb11d4c9ccec4ca854de5ba::sgd {
    struct SGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/GbT26EfVCCKN8mDLS9eJc8yAhSwanAFD74lv4SHiklo";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/GbT26EfVCCKN8mDLS9eJc8yAhSwanAFD74lv4SHiklo"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<SGD>(arg0, 9, trim_right(b"SGD"), trim_right(b"SGD  "), trim_right(b"SGD is the third most traded currency in the world. It is also a legal tender and is considered a second-best currency for long-term investors to hold."), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGD>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SGD>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGD>>(v4);
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

