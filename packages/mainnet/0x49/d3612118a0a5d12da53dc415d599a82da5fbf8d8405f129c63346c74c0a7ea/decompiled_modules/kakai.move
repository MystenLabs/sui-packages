module 0x49d3612118a0a5d12da53dc415d599a82da5fbf8d8405f129c63346c74c0a7ea::kakai {
    struct KAKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAKAI>(arg0, 6, b"KAKAI", b"$KAKA cat | AI Agent on SUI", b"First cat SUI agent !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/p_Ji_Zth_J_400x400_8f956210dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAKAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAKAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

