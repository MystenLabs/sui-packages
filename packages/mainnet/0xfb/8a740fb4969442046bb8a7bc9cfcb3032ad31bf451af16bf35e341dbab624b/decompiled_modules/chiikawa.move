module 0xfb8a740fb4969442046bb8a7bc9cfcb3032ad31bf451af16bf35e341dbab624b::chiikawa {
    struct CHIIKAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIIKAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIIKAWA>(arg0, 6, b"Chiikawa", b"Usagi", b"Usagi means rabbit in Japanese. Some people also translate it as \"Usagi\" in Chinese, and some fans call him \"Brother Rabbit\". His birth day is January 22, 2019. Although he cannot speak, his most distinctive feature is his loud cry!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8901_fafe0a7fae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIIKAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIIKAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

