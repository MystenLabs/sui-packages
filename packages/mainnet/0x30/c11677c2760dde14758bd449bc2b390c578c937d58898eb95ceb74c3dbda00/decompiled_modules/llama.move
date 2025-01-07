module 0x30c11677c2760dde14758bd449bc2b390c578c937d58898eb95ceb74c3dbda00::llama {
    struct LLAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLAMA>(arg0, 6, b"LLAMA", b"LLAMA Coin", b"LLAMA Coin is a meme-inspired cryptocurrency that brings the quirky charm of llamas to the digital asset world. Born from internet culture, LLAMA Coin aims to build a vibrant community around humor, creativity, and shared enthusiasm. It's more than just a coinit's a movement that celebrates the lighter side of blockchain technology. Join the herd and be part of a crypto experience that's as unique and entertaining as the llamas themselves!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/llama_coin_f6eac34841.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LLAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

