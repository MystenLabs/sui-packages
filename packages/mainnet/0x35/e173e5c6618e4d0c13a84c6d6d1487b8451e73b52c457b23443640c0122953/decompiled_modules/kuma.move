module 0x35e173e5c6618e4d0c13a84c6d6d1487b8451e73b52c457b23443640c0122953::kuma {
    struct KUMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUMA>(arg0, 6, b"KUMA", b"Kuma on Sui", b"The Chosen One $KUMA has arrived.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_RH_Tv_Hxr_400x400_7c560de3d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

