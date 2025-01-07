module 0x59343c4d4cbfcbd678978a7524512ad493773c967333b03af718e75a467fa709::mick {
    struct MICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICK>(arg0, 6, b"MICK", b"Nightmare Mick", b"Yo, meet Mick! He's a one-of-a-kind character who's famous for bringing good fortune. Mick's got that magic touch, turning everything he gets involved in into pure gold. When Mick's around, you know things are about to get real lucky. Get ready for some serious good vibes with Mick and your new favorite crypto token!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1x1_5e84b68a56.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

