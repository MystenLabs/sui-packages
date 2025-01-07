module 0xfffe9281b13f0ff43452c54c5ab1cbb9a8f478e03a1960faecdcb15bf7c71a5a::tromb {
    struct TROMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROMB>(arg0, 6, b"TROMB", b"TROMBING", b"TRUMB is a meme token in the Sui ecosystem created in support of Donald Trump. The name combines Trump's name and the spirit of memes, giving it a lighthearted and playful nature suitable for the crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950655486.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROMB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROMB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

