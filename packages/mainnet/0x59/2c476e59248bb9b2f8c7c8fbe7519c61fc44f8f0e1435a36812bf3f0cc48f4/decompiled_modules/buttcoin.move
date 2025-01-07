module 0x592c476e59248bb9b2f8c7c8fbe7519c61fc44f8f0e1435a36812bf3f0cc48f4::buttcoin {
    struct BUTTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTTCOIN>(arg0, 6, b"BUTTCOIN", b"Buttcoin", b"In an era of meme coins that become irrelevant as quickly as they appear, Buttcoin aims to stand out as a long-term meme related to the ultimate crypto, Bitcoin. We are crafting written and narrated lore about the Rise of Buttcoin and the Great Meme Wars. See our socials! Please don't spend any money you intend to get back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3452345_d2b580ec91.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTTCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

