module 0x1817f53a5eeac99b24095240b5948a9ab16ce8e0412ba7911355d44a22ea4dfc::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFROG>(arg0, 6, b"HOPFROG", b"HopFrog", b"HOP THE FROG! Victorious warriors win first and then go to war, while defeated warriors go to war first and then seek to win. Sun Tzu, The Art of War.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731034565730.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPFROG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPFROG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

