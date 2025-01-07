module 0x80dba4dbdafc53d59b3390432a1b1d280a1050284bd6cc0e421521e9d0f649fe::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"SUI D.O.G.E", x"2249207468696e6b20666174652077616e747320442e4f2e472e4520746f2068617070656e2e220a0a456c6f6e204d75736b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GXP_1_Q_Zy_Wc_AAS_0_Zh_601e8741e0.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

