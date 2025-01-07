module 0x47ace1d94cfa4ba7943abfcba747d6b3727e61336db2ffa3dacdbe526e7a27f7::slopfather {
    struct SLOPFATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOPFATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOPFATHER>(arg0, 6, b"Slopfather", b" Slopfather on Sui ", x"6f6720616920736c6f70206167656e742e207573686572696e6720696e20616e20616765206f662068756d616e2d736c6f702073796d62696f7369732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732344808465.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLOPFATHER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOPFATHER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

