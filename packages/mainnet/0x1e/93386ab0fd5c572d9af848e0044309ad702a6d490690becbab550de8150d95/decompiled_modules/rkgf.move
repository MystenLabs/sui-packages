module 0x1e93386ab0fd5c572d9af848e0044309ad702a6d490690becbab550de8150d95::rkgf {
    struct RKGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RKGF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/Go4EjanmpGhu_iCmGQzOtA5Rj_ADD31SR6YHYWdsPmM";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/Go4EjanmpGhu_iCmGQzOtA5Rj_ADD31SR6YHYWdsPmM"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<RKGF>(arg0, 8, trim_right(b"RKGF"), trim_right(b"RKGF  "), trim_right(b"RKGFGOFAN"), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RKGF>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<RKGF>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RKGF>>(v4);
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

