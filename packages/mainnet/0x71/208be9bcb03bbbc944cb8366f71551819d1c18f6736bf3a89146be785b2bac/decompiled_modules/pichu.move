module 0x71208be9bcb03bbbc944cb8366f71551819d1c18f6736bf3a89146be785b2bac::pichu {
    struct PICHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICHU>(arg0, 6, b"PICHU", b"PICHU SUI", b"Pichu, a Tiny Mouse Pokemon, is the pre-evolution of Pikachu, meaning it evolves into Pikachu. Pichu is described as small, plump, and yellow, with black ear tips, a black collar, and a black, lightning bolt-shaped tail.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidzguzklwcvjvgahd7xzpxc22aa5rblbpk5nq6k6ejzb7bh3dt4ou")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PICHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

