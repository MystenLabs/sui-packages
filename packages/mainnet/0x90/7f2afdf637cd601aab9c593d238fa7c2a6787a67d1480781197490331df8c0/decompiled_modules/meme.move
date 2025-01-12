module 0x907f2afdf637cd601aab9c593d238fa7c2a6787a67d1480781197490331df8c0::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 6, b"MEME", b"Meme token", b"Meme coins are cryptocurrencies inspired by internet memes or cultural trends, often created as jokes or for entertainment purposes. Popular examples include Dogecoin (DOGE) and Shiba Inu (SHIB), which gained significant attention due to community support", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/f7d85b8c-80f3-4b6a-a1d6-25530c0d8dec.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

