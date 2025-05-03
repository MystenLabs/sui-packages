module 0xca32f4d81673dbc757ac858fbff1c1d08888877e98a0f58ae6df49c2427d51d7::clyno {
    struct CLYNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLYNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLYNO>(arg0, 6, b"Clyno", b"Clynosaurs", b"Just meme no utility", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibyjidwmcfuh65j6xpdrazkb3vya33ih3542itgpiimimczbecjs4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLYNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CLYNO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

