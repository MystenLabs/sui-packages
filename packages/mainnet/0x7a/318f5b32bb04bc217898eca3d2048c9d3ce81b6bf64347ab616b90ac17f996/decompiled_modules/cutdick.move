module 0x7a318f5b32bb04bc217898eca3d2048c9d3ce81b6bf64347ab616b90ac17f996::cutdick {
    struct CUTDICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTDICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUTDICK>(arg0, 6, b"Cutdick", b"Cutdickman", b"This meme comes from a real event. A real meme that happened in the sui trades group is now with you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig6no3jf4ea6u32nytuk7na6m3l36lrn5464kxv2rubo3filvmtim")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUTDICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CUTDICK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

