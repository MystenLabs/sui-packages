module 0x8f7ef5a5a3b4c38cda1f387674bcc0b7b122d5ac4f14a4c78aba6868c3d70c92::GENERAL {
    struct GENERAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENERAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENERAL>(arg0, 6, b"SIR GENERAL", b"GENERAL", b"A meme coin dedicated to the fearless generals of the meme wars, leading the charge from the digital trenches. TRENCH is the currency of meme culture resilience, humor, and community-driven chaos. Holders enlist in the army of viral dominance, where every transaction is a battle cry for meme supremacy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreibgujvlygf2jekykegdlyfguojmzfnrhub5y2vivqq3xkracl5wsm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENERAL>>(v0, @0x691c5d4f7bd7c39b39907d3ca01b8c2643c87de134766ca4f78be51e0a9fde1b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENERAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

