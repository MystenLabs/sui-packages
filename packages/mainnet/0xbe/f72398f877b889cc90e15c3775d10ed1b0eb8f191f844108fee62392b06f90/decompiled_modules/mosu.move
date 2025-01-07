module 0xbef72398f877b889cc90e15c3775d10ed1b0eb8f191f844108fee62392b06f90::mosu {
    struct MOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSU>(arg0, 6, b"MOSU", b"MONALI SUI", x"546869732069736e2774206a75737420616e79207265696e746572707265746174696f6e2e204d6f6e61206c697375692069732074686520627261696e6368696c64206f6620526574617264696f20446176696e636920616e642074686520776f726c64e2809973206d6f73742066616d6f7573206d656d65207061696e74696e672ee280a84e6f7720617661696c61626c6520666f72207075626c6963206f776e657273686970206f6e207468652053554920626c6f636b636861696e206e6574776f726b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958706793.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

