module 0x4a8823f29cf2cd7af515b2a0569d9f5ad64c13099e77094b31ba92c226f0ad71::pws {
    struct PWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWS>(arg0, 6, b"Pws", b"Pawsui", b"Pawsul (Pws) - the meme coin inspired by our favorite four-legged friends! This token is for dog lovers who want to wag their way into the crypto world. With a loyal community and a playful spirit, Pawsul is more than just a token - its a furry adventure packed with fun and profits! Join the pack, invest in Pawsul, and lets bark our way to the moon! \"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009704_99e317f60f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

