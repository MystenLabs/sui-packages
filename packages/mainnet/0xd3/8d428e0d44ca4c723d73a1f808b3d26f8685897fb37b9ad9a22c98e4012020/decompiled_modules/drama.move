module 0xd38d428e0d44ca4c723d73a1f808b3d26f8685897fb37b9ad9a22c98e4012020::drama {
    struct DRAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DRAMA>(arg0, 6, b"DRAMA", b"DramaLlama by SuiAI", b"The meme coin that adds drama to your portfolio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/LLAMA_6bef85e0b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRAMA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAMA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

