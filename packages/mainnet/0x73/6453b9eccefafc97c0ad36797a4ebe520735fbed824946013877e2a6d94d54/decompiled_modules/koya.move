module 0x736453b9eccefafc97c0ad36797a4ebe520735fbed824946013877e2a6d94d54::koya {
    struct KOYA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<KOYA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KOYA>>(0x2::coin::mint<KOYA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KOYA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HGW9fbnC7RDNPAe5NJdyh9qvJ6EkYafMm5Bh8Hh9gu4d.png?size=lg&key=90c188                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KOYA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KOYA    ")))), trim_right(b"KOYA                            "), trim_right(x"496e204b4f5941277320776f726c642c206d616b696e67206d6f6e657920646f65736e2774207265717569726520776f726b696e6720686172642e20436c657665722061732068652069732c204b4f59412068617320616c72656164792066696775726564206f7574207468652073656372657420746f206561726e696e67207768696c6520736c656570696e672e204b4f5941206c65747320796f75722077616c6c65742071756965746c792067726f77207768696c6520796f752772652074616b696e672061206c69676874206e61702e204a6f696e204b4f5941277320647265616d6c616e64206e6f772c20616e64206c6574277320636f756e74206d6f6e6579207768696c6520776520736c656570210020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOYA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KOYA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<KOYA>>(0x2::coin::mint<KOYA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

