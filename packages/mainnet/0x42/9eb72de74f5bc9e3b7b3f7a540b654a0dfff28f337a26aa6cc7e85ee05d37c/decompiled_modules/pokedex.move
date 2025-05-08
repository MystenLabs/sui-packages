module 0x429eb72de74f5bc9e3b7b3f7a540b654a0dfff28f337a26aa6cc7e85ee05d37c::pokedex {
    struct POKEDEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEDEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEDEX>(arg0, 6, b"Pokedex", b"PokedexSui", b"Pokedex Tracker is a cutting-edge platform built on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicbptejiap3j7fe3qlh2zny3v5rqtccmuftqcpx6p2lhmqw7odmji")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEDEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEDEX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

