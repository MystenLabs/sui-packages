module 0x32727ad871176ac03a528f059bcf9de71f988f1e0b0fab47a94415d269969339::dragon {
    struct DRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGON>(arg0, 6, b"DRAGON", b"LitchDragonSui", b"Not just any dragon, this is the strongest dragon that has ever existed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidjsl33p5gal2os6cqv4kskuwckrzefpqlbamugupo5mwyqnocmpm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRAGON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

