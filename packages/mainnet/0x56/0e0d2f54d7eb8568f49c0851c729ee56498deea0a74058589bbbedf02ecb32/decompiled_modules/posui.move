module 0x560e0d2f54d7eb8568f49c0851c729ee56498deea0a74058589bbbedf02ecb32::posui {
    struct POSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSUI>(arg0, 6, b"POSUI", b"POSSUI", b"first possum on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/is8jz_Hs_X_400x400_5c03fb707b_1b31e12b8c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

