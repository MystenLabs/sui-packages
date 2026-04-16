module 0x9ae83fe6d8fbb57b0829be235f3315d153cc0dd24ca9fa195a5a1cf72b508b33::trade {
    struct TRADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRADE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776369438190-d7c7b6ae4f814096047c6a1a528558ee.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776369438190-d7c7b6ae4f814096047c6a1a528558ee.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<TRADE>(arg0, 9, b"TRADE", b"TradeDotFUN", b"TradeDOTFUN", v1, arg1);
        let v4 = v2;
        if (10000000000000000 > 0) {
            0x2::coin::mint_and_transfer<TRADE>(&mut v4, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRADE>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRADE>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

