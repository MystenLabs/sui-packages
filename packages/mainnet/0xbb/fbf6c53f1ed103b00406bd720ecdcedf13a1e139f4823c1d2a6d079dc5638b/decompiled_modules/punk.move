module 0xbbfbf6c53f1ed103b00406bd720ecdcedf13a1e139f4823c1d2a6d079dc5638b::punk {
    struct PUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNK>(arg0, 6, b"Punk", b"Cypherpunk", b"Cypherpunk is a retro-culture rising from the deep code of the Sui blockchain. Powered by hackers of the electronic frontier, we declare our code-driven meme manifesto! No roadmap, no promises, and pure fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017538_463f2a13ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

