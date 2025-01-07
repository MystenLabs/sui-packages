module 0xd660bb109621505e29f7430cf93d98229c01ca6fb011f8c2148ca5c2e56cbb4::sigma {
    struct SIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGMA>(arg0, 6, b"Sigma", b"Wormhole Sigma onSui", x"506f7765726564206279200a40576f726d686f6c650a2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Yatxr_Jb_YA_Auy_d_1_0b4de2b42c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

