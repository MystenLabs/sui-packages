module 0x3195495b679df1894253ce76c2703b12a7f755a1a3ec6bfaa13528f39d09801f::moggy {
    struct MOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOGGY>(arg0, 6, b"MOGGY", b"Moggy Sui", b"Moggy the introvert goblin thats going to watching from the shadows and seizing the moment thats going to wow everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ruo_YT_Oo_M_400x400_fc49b250f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

