module 0xc5a2fadda325bb7c8d29a5d95b7bbf1bbbd5ab7408db6cc8fd7bcbc81003cbb6::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"D.O.G.E", b"Department Of Government Efficiency - Led by Elon Musk and Vivek Ramaswamy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gc_Oy_C21_W4_A_At_T7_P_1_bd3c359838.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

