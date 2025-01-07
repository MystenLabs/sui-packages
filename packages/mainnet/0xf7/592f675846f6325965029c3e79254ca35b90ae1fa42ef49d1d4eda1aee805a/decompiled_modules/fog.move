module 0xf7592f675846f6325965029c3e79254ca35b90ae1fa42ef49d1d4eda1aee805a::fog {
    struct FOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOG>(arg0, 9, b"FOG", b"Fag Dog", b"The cutest, chubbiest meme coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844132604599017472/mMTgpYRg_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

