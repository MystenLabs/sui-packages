module 0x883b1de645d31bbde1e98f868f8edf491e9c81dcdddb53013e904ce7c989f1d3::ting {
    struct TING has drop {
        dummy_field: bool,
    }

    fun init(arg0: TING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TING>(arg0, 6, b"Ting", b"Tingo", b"Tingo is a world-famous lizard. He intends to be a good investment option and donate 2.5% of his income to charity. Tingo plans to distribute NFTs of himself to his investors in the future. Tingo wishes for the world to be full of peace and kindness.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000224824_2fde481e4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TING>>(v1);
    }

    // decompiled from Move bytecode v6
}

