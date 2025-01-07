module 0x1da103242b667236bcf33944d34d0073a3554290652b72225f5d4a7e166b5854::gbtc {
    struct GBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBTC>(arg0, 6, b"GBTC", b"Gary X BTC", b"SEC accept BTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734663038837.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

