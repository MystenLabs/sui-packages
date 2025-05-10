module 0x2b9bea697ab142b620d1103d7f294ff9483def58c268f7b6856a0e9963efb2b0::capov2 {
    struct CAPOV2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPOV2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPOV2>(arg0, 6, b"CAPOV2", b"Capo V2 The AI", b"CAPO V2 is not just a token  it's also a Telegram AI voice changer app, allowing you to upload and use custom voice files with advanced AI functionality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibcl2st3yooglr5gkka7hrdjg6dq6domt2rjyl7vwvjhsu2cm6rwu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPOV2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAPOV2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

