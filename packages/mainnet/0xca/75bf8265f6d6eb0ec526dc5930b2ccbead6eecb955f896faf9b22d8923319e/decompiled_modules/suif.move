module 0xca75bf8265f6d6eb0ec526dc5930b2ccbead6eecb955f896faf9b22d8923319e::suif {
    struct SUIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIF>(arg0, 6, b"SUIF", b"PuffSui", b"PuffSui is a lighthearted, meme-driven cryptocurrency built on the fast scalable and efficient Sui blockchain With a fun, pufferfish-inspired mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibzvb6eklfkrhuejjkvwnlrzi2u3xqgdy6qeumapsvanv5mukahsi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

