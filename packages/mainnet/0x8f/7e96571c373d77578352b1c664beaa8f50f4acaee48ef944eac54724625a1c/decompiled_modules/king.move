module 0x8f7e96571c373d77578352b1c664beaa8f50f4acaee48ef944eac54724625a1c::king {
    struct KING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING>(arg0, 6, b"KING", b"Meme King", b"I asked an AI art generator to create a crypto meme king. My prompts were - crypto, king of memes, future, humorous, king of world, cool with swagger. Now he just needs a community to serve. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crypto_king_c5f60d6714.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KING>>(v1);
    }

    // decompiled from Move bytecode v6
}

