module 0x22f1b6f21c05e3da4900d3db8b2e46924ff4bd1bb67e88eaaa3e8d9959a6725f::forth {
    struct FORTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORTH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/8OIdwkSZBTl13-G4D7wat8rrkbyfvS6caLEA2Qc_EkI";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/8OIdwkSZBTl13-G4D7wat8rrkbyfvS6caLEA2Qc_EkI"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<FORTH>(arg0, 9, trim_right(b"FORTH"), trim_right(b"FORTH  "), trim_right(b"good boy"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (99999998000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<FORTH>>(0x2::coin::mint<FORTH>(&mut v5, 99999998000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORTH>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<FORTH>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORTH>>(v4);
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

