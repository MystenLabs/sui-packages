module 0x6339c170192a7465ec029ca6a822c37182a90352b39999a4d8140d7f11851b9a::promise {
    struct PROMISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROMISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROMISE>(arg0, 6, b"PROMISE", b"RIP Wara", b"Wara keeps his promises, he really is a man who really keeps his promises", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiactgencz4km2tly2zllostcvieuaqzng6hdesvecrdy5rgxyyyem")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROMISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PROMISE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

