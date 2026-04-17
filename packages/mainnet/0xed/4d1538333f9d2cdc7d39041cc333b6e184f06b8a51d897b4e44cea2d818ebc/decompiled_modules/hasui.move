module 0xed4d1538333f9d2cdc7d39041cc333b6e184f06b8a51d897b4e44cea2d818ebc::hasui {
    struct HASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776433239405-ae161306af3da4d27cddd14b3adff9e4.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776433239405-ae161306af3da4d27cddd14b3adff9e4.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<HASUI>(arg0, 9, b"haSUI", b"haSUI", b"lend and stake", v1, arg1);
        let v4 = v2;
        if (110000000000 > 0) {
            0x2::coin::mint_and_transfer<HASUI>(&mut v4, 110000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASUI>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HASUI>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

