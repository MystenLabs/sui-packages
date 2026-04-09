module 0xbbf4b9fe6d82eaffffc946a13f2f9d929c53885c1178b81318e14f2164abb905::deep {
    struct DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775772560850-9854b6565858b949f17ba765a77fc91a.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775772560850-9854b6565858b949f17ba765a77fc91a.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<DEEP>(arg0, 9, b"DEEP", b"DeepSeek", b"=DEEP Coin Good Coin", v1, arg1);
        let v4 = v2;
        if (21000000000000000 > 0) {
            0x2::coin::mint_and_transfer<DEEP>(&mut v4, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEP>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEEP>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

