module 0x921216ab400aaad72600506776fe6395955711727c04c6187b497a200981e6e1::shrump {
    struct SHRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRUMP>(arg0, 6, b"SHRUMP", b"Shrump", b"Trump as a Schrimp in the deep blue sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EA_Pz2_LG_Xk_AAX_Yko_22d50e357c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

