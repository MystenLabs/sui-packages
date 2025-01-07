module 0xc57bc456bb129c27fd2c8b39e0f8748eb5b4ffea4cac99dbb5a60b86f87d8a93::sbrett {
    struct SBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBRETT>(arg0, 6, b"Sbrett", b"SUI BRETT", b"From BASE to SUI, SuiBrett evolved, faster, stronger, and ready to moon any meme coin in his path! $SBRETT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5151_4a457f3dc8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

