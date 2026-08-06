module 0x8eb7ec494cca4b8b0c64054c06d9535ac69456a399f3ee8fb416a4db9108df3e::uads {
    struct UADS has drop {
        dummy_field: bool,
    }

    fun init(arg0: UADS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/l_err4ahxGrwHg-5ovcjlo1mdDhqf1lsMIlU36hgmlQ";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/l_err4ahxGrwHg-5ovcjlo1mdDhqf1lsMIlU36hgmlQ"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<UADS>(arg0, 9, trim_right(b"UADS"), trim_right(b"UADS  "), trim_right(b"UADS "), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (1000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<UADS>>(0x2::coin::mint<UADS>(&mut v5, 1000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UADS>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<UADS>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UADS>>(v4);
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

