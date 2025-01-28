module 0x43e4733bb6e158dc88425ce08d252059a5b8f196f46e27b5f4d4a8ca4671ef06::cuckd {
    struct CUCKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUCKD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafkreifpqc5babtzdl4hwzqe337a4kfmn7o27cr5n2b3hqtn2ffxcoawse                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<CUCKD>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CUCKD   ")))), trim_right(b"CUCKD Token                     "), trim_right(b"CUCKD Token represents peak cuckery                                                                                                                                                                                                                                                                                             "), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<CUCKD>>(0x2::coin::mint<CUCKD>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CUCKD>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUCKD>>(v3);
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

