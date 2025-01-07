module 0x5b1b9752d13320c9842cd227c5cc78cc1d99a007ede5bac2da569afaf1863e83::loading {
    struct LOADING has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOADING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOADING>(arg0, 6, b"LOADING", b"BONDING CURVE TO 100", b"seend it to 100 bonding curve", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fbf4b4b5b982c142d6b25d8bf45daa40_29be865ea2.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOADING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOADING>>(v1);
    }

    // decompiled from Move bytecode v6
}

