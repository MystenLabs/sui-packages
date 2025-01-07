module 0xb5c0ea73c2f2ae9156d0fa263295e397a6a0d006740931033b9a73128de590b0::toro {
    struct TORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORO>(arg0, 6, b"TORO", b"TORUI", b"El Toro is the sacred Guardian of the bull market! As prophesied in the Holy Bullble, his blessed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/window_d5b188da87.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

