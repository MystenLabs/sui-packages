module 0x665088281839e725aeb5f6f5e90cf6e1a53211960ac0796cb3724a60ee1ca6ff::lol {
    struct LOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LOL>(arg0, 6, b"LOL", b"MemeVerse", b"MemeVerse is a groundbreaking digital realm that brings laughter, creativity, and innovation into the crypto world. This token is designed for meme enthusiasts who can create, vote, trade, and even earn through their memes. MemeVerse transforms creativity from just entertainment into an opportunity to build a happier and more rewarding digital future..#MemeEconomy #FunToken #CryptoLaughs #InternetCulture #NFTMemes..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/lol_cd803193a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

