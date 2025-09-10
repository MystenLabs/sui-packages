module 0x3e24e85b65065f939f3e87eda192773549c11e2eeff789ac36920e382cdf65c3::aic {
    struct AIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/kk-oE_E_DxhG-0VABwrTKorgGKMTw7uKgYQFrDcA-b8";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/kk-oE_E_DxhG-0VABwrTKorgGKMTw7uKgYQFrDcA-b8"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<AIC>(arg0, 5, trim_right(b"AIC"), trim_right(b"AIConnect"), trim_right(b"https://aiconnects-organization.gitbook.io/ai-connect-whitepaper"), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIC>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AIC>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIC>>(v4);
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

