module 0xeaa5ec59da3517549f9f98f4419b2b476d6abfd7e612b8d8eb515e69054978ee::lit {
    struct LIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIT>(arg0, 6, b"LIT", b"WET - A Burned Meme moving Through SUI", b"$LIT is a burned Entity born from the fire of the blockchain. A symbol. A flare. A movement. Burning through Sui, rare, untamed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiec2uynppnnreuibs2yql4cnv3sba3r47au6xolu3lxvfnhthol7m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LIT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

