module 0xff97e3a576fb648b2180920cf1ba9998ca99e6dcfef5fdd40c6586a545a680e3::aqos {
    struct AQOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQOS>(arg0, 6, b"AQOS", b"AQUAonSui", b"Stay wet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigv5eg34sfiqvzweaj6hzbneq2wp2ktono3imtzlu76x3u7nfcqei")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AQOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

