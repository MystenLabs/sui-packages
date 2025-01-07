module 0x43e67401053fdecd0773e0f5d66d386e1a6a91e1b9fa9486da5e7ac0b137ae05::ohhhhhhhhhhhhhhhhhhhhhhhhh {
    struct OHHHHHHHHHHHHHHHHHHHHHHHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: OHHHHHHHHHHHHHHHHHHHHHHHHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OHHHHHHHHHHHHHHHHHHHHHHHHH>(arg0, 6, b"Ohhhhhhhhhhhhhhhhhhhhhhhhh", b"Oh YES", b"ohhhhh yesssssss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2985b6c034a78d701ceec2ecf88fb759_bffa984dd2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OHHHHHHHHHHHHHHHHHHHHHHHHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OHHHHHHHHHHHHHHHHHHHHHHHHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

