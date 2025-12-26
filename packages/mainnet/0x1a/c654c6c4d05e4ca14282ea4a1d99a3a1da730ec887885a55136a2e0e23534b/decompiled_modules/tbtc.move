module 0x1ac654c6c4d05e4ca14282ea4a1d99a3a1da730ec887885a55136a2e0e23534b::tbtc {
    struct TBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/Dh-IiQku7NBHQgIZWZ5MTkwGCbPWPdcB-XIWn55pDto";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/Dh-IiQku7NBHQgIZWZ5MTkwGCbPWPdcB-XIWn55pDto"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<TBTC>(arg0, 6, trim_right(b"tBTC"), trim_right(b"TestBTC"), trim_right(b"Test BTC developed based on Sui blockchain"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (100000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TBTC>>(0x2::coin::mint<TBTC>(&mut v5, 100000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBTC>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TBTC>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TBTC>>(v4);
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

