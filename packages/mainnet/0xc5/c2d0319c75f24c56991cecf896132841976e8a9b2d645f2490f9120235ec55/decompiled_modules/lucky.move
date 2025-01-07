module 0xc5c2d0319c75f24c56991cecf896132841976e8a9b2d645f2490f9120235ec55::lucky {
    struct LUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCKY>(arg0, 6, b"LUCKY", b"Lucky Dog", b"Introducing $LUCKY, the luckiest dog in the world now taking over SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_LTK_3jf_R_400x400_8de99df520.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

