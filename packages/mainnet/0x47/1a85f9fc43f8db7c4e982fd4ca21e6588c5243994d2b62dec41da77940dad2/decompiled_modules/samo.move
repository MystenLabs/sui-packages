module 0x471a85f9fc43f8db7c4e982fd4ca21e6588c5243994d2b62dec41da77940dad2::samo {
    struct SAMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMO>(arg0, 6, b"SAMO", b"SAMO on SUI", b"Top up with $SAMO, tap, and shop with your  money today.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mz_Aq4_Fn_400x400_313d5f0c47.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

