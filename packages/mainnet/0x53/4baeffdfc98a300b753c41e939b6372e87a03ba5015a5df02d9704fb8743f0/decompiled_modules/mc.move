module 0x534baeffdfc98a300b753c41e939b6372e87a03ba5015a5df02d9704fb8743f0::mc {
    struct MC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1719569171797-15e87177937e9581fc8e391f9ab77571.jpeg";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1719569171797-15e87177937e9581fc8e391f9ab77571.jpeg"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<MC>(arg0, 9, b"MC", b"Merry Christmas", b"Description", v1, arg1);
        let v4 = v2;
        if (1000000000000000 > 0) {
            0x2::coin::mint_and_transfer<MC>(&mut v4, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MC>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MC>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

