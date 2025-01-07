module 0xd588484bbc6da378636036d25dfaad0269c66a92d3d1b6e5d096093c547e11a3::lana {
    struct LANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LANA>(arg0, 6, b"LANA", b"Thong Lana", b"Thonglana is not your ordinary rabbit; it's a groundbreaking creation that has been equipped with a neural link implant by the visionary Elon Musk. This technological marvel has elevated Thonglana to unprecedented levels of intelligence, making it the smartest AI rabbit ever conceived. What sets Thonglana apart is not just its exceptional cognitive abilities but also its unique fashion statement. Embracing its futuristic enhancements with style, Thonglana has ingeniously chosen a thong as its signature accessory, seamlessly incorporating cutting-edge technology into a trendy and eye-catching fashion statement. Explore the world of Thonglana and witness the convergence of technology and fashion in a way that's never been seen before.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CF_8_BET_Zz76d_SX_9j_Ar_Y_Ea_L3jut_Jo_We3_UPLL_9_CR_222pump_6456019c0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

