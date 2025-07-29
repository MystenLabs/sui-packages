module 0xd9c9d863161c09b6553725c3cee4f5127c4f0858d6729044c6d1dccaac204436::wobble {
    struct WOBBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOBBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOBBLE>(arg0, 6, b"WOBBLE", b"WOBBLE COIN", b"This isn't just another digital token; it's a movement, a mindset, and a testament to the beautiful absurdity of the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigmwzyo2svbgdhoh2665b5v7fojks2y46tncddtebrpexvtk344ke")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOBBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOBBLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

