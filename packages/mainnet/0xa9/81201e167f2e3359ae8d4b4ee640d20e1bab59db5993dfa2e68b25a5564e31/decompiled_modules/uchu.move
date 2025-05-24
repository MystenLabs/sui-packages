module 0xa981201e167f2e3359ae8d4b4ee640d20e1bab59db5993dfa2e68b25a5564e31::uchu {
    struct UCHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: UCHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UCHU>(arg0, 6, b"Uchu", b"Unichu", b"Unichu is a Sui meme based on the co-founder Evan Chengs dog called Uni, customized into a Pokemon character $Uchu $Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihyirkokxnazchj3priftcmovqm2ibiwrracavb7acasy5es4p4ki")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UCHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UCHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

