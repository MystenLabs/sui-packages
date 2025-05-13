module 0x3c8675a786dcf6bf04ca79ec378b43a2d7adcf5dfc8ed621ab6a9337e2190f19::sjsw {
    struct SJSW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJSW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJSW>(arg0, 6, b"Sjsw", b"Hausj", b"Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih5js54gnuxpdzsewn3gne7ociyt26brddze4ghria2c5663ykinu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJSW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SJSW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

