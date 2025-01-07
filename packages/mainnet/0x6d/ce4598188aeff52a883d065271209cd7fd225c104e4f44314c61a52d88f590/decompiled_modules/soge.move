module 0x6dce4598188aeff52a883d065271209cd7fd225c104e4f44314c61a52d88f590::soge {
    struct SOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOGE>(arg0, 6, b"SOGE", b"SuiDoge", b"Soge, Sui Doge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_RAR_Pv_DO_400x400_d05d26ad25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

