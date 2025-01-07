module 0x6d79a2b195f41a482a71c863bb4c2335e581af16aaa83a3334c94c556cc3724e::mick {
    struct MICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICK>(arg0, 6, b"MICK", b"Nightmare Mick", b"Yo, meet Mick! He's a one-of-a-kind character who's famous for bringing good fortune. Mick's got that magic touch, turning everything he gets involved in into pure gold. When Mick's around, you know things are about to get real lucky. Get ready for some serious good vibes with Mick and your new favorite crypto token!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1x1_ab2db92a32.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

