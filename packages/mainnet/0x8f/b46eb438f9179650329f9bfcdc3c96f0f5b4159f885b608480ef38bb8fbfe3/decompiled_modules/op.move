module 0x8fb46eb438f9179650329f9bfcdc3c96f0f5b4159f885b608480ef38bb8fbfe3::op {
    struct OP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/8hvSY4Bk1JZYMYLVd4rqYZ9MwMFhQKSayEmxCwtqKayp";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/8hvSY4Bk1JZYMYLVd4rqYZ9MwMFhQKSayEmxCwtqKayp"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<OP>(arg0, 9, trim_right(b"OP"), trim_right(b"Open"), trim_right(b"asdasdafbhgwrh"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (100000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<OP>>(0x2::coin::mint<OP>(&mut v5, 100000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OP>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<OP>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OP>>(v4);
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

    // decompiled from Move bytecode v7
}

