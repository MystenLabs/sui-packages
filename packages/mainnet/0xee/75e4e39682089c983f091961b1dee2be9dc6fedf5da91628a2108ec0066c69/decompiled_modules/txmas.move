module 0xee75e4e39682089c983f091961b1dee2be9dc6fedf5da91628a2108ec0066c69::txmas {
    struct TXMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TXMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TXMAS>(arg0, 6, b"TXMAS", b"Trumpt Exmas", b"Let me tell you, folks, $TXmas is not just another meme coinit's the best, believe me. We're combining the fantastic Christmas spirit with the tremendous power of cryptocurrencies, and this isn't just for the holidays. This is a long-term, incredible project that will never stop growing, never stop updatingalways getting better. We're bringing smiles and creating unbelievable value for our community every single day. Make your future more exciting than ever with our unique tokenit's going to be huge, you won't believe it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049556_b10ddb5b92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TXMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TXMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

