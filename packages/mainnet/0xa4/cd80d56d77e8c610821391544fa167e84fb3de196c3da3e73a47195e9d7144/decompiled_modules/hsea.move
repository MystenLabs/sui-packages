module 0xa4cd80d56d77e8c610821391544fa167e84fb3de196c3da3e73a47195e9d7144::hsea {
    struct HSEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSEA>(arg0, 6, b"HSEA", b"SuiHorSea", b"$HORSEA is a meme coin on the Sui Network inspired by the beloved Water-type Pokmon, Horsea. Just like its namesake, $HORSEA is small but powerful, ready to make big waves in the crypto world. Backed by a community of trainers and degens, this playful token brings nostalgia, fun, and decentralized energy to the Sui ecosystem. Catch it earlybefore it evolves!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0635_c9a97dde42.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HSEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

