module 0xa74d5d3a0bf32aa95fdc497e14bc331e327563ac78354367d2e6ed726fbfbe66::crappy {
    struct CRAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAPPY>(arg0, 6, b"CRAPPY", b"CRAPPY BIRD SUI", b"Built on Sui : https://www.crappybirdsui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ohb_Ux_QVD_400x400_dc3fc4da1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

