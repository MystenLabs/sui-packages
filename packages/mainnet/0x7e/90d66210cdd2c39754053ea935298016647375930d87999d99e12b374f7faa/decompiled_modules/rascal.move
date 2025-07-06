module 0x7e90d66210cdd2c39754053ea935298016647375930d87999d99e12b374f7faa::rascal {
    struct RASCAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RASCAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RASCAL>(arg0, 6, b"RASCAL", b"Rascal the Crypto Raccoon", b"Rascal the Crypto Raccoon! A raccoon (natural scavenger) perfectly represents crypto traders hunting for gains.  He's the perfect meme character for the crypto community - a dedicated degen trader who embodies the \"diamond hands\" mentality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibeq4eur6tmsuzahk5cuweey2pahbktlfhsikvegoslttc2qgljne")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RASCAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RASCAL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

