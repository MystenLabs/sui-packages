module 0x551508a61e485aa3c5a35ae45e7b5c21078df528b83e4b23bbf721dd9503a2da::zmb {
    struct ZMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZMB>(arg0, 6, b"ZMB", b"Zombseis", b"Spreading positivity & building the best SEI community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidhzly4a7gawaxgykp52bc5xhfefhixxl3fzwhdwjzu4t6x6mvsba")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZMB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

