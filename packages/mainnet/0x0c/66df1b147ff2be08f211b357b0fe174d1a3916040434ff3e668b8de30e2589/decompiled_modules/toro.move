module 0xc66df1b147ff2be08f211b357b0fe174d1a3916040434ff3e668b8de30e2589::toro {
    struct TORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORO>(arg0, 6, b"TORO", b"TORUI", b"El Toro is the sacred Guardian of the bull market! As prophesied in the Holy Bullble, his blessed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/window_b8a7b10949.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

