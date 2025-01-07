module 0x35e4cbb6400452e13e3310feb99d0ad05121c84c235222f2cce43b82eb551015::whaly {
    struct WHALY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALY>(arg0, 6, b"Whaly", b"WHALY", b"$Whaly drawn by the currents of opportunity, it swallows up every weak sell-off, leaving waves of profits in its wake.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_YL_1vf_Oq_400x400_67abf01c72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALY>>(v1);
    }

    // decompiled from Move bytecode v6
}

