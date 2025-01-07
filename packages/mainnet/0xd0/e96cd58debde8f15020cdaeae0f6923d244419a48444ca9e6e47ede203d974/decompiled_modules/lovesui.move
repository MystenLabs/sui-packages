module 0xd0e96cd58debde8f15020cdaeae0f6923d244419a48444ca9e6e47ede203d974::lovesui {
    struct LOVESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVESUI>(arg0, 6, b"LOVESUI", b"LOVE on SUI", b"Love is coming to  SUI. We Love Airdropping You.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RI_5_B9yn_T_400x400_2e63f8f53d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOVESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

