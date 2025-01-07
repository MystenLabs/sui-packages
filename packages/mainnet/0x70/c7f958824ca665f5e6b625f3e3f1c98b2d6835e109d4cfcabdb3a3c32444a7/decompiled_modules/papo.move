module 0x70c7f958824ca665f5e6b625f3e3f1c98b2d6835e109d4cfcabdb3a3c32444a7::papo {
    struct PAPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPO>(arg0, 2, b"PAPO", b"Paddle Pop", b"PAPO Token: The Fun Meme Coin  Lop Token is a vibrant and community-driven meme coin designed to bring joy and laughter to the crypto space. With a playful and engaging brand, Lop aims to create a lighthearted atmosphere while fostering a strong community of supporters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAnhF8fGMoiIAibLe8tkdeJEBQWE3PKP3c5w&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAPO>(&mut v2, 50000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

