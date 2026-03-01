module 0x6d3f33b8e58962d5ca8a784da16047f771cddde8c79335cda9e9fd99910ffbea::soulink {
    struct SOULINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOULINK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/hxlEVcDeWKu3RSOFBnhS5WdriT6tLp-8TquSy1BbOkY";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/hxlEVcDeWKu3RSOFBnhS5WdriT6tLp-8TquSy1BbOkY"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<SOULINK>(arg0, 1, trim_right(b"SOULINK"), trim_right(b"SOULINK  "), trim_right(b"Crypto Payments on Sui Network. Authors get paid directly in SOULINK, Sui's fast, low-fee native token. Set your wallet once, share a QR/link, receive instant global payments. No intermediaries, no fees. Full control: your content and money are yours."), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (188880 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SOULINK>>(0x2::coin::mint<SOULINK>(&mut v5, 188880, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOULINK>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SOULINK>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOULINK>>(v4);
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

