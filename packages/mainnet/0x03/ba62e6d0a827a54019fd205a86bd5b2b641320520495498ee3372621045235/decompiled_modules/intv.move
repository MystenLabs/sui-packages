module 0x3ba62e6d0a827a54019fd205a86bd5b2b641320520495498ee3372621045235::intv {
    struct INTV has drop {
        dummy_field: bool,
    }

    fun init(arg0: INTV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INTV>(arg0, 6, b"INTV", b"Intellivision", b"Dive into nostalgia with INTV on Sui! Inspired by the groundbreaking Intellivision, this coin celebrates 80s gaming's advanced graphics and unique gameplay. Relive the past, build the future on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidoghp7xq2eymq62ynjasm6ngy7755nvdjlvrjuw4ndztj3y23q5a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INTV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<INTV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

