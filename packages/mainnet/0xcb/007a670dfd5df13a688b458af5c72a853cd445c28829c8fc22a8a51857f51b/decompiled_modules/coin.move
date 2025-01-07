module 0xcb007a670dfd5df13a688b458af5c72a853cd445c28829c8fc22a8a51857f51b::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COIN>(arg0, 6, b"MUNCAT", b"MUNCAT", x"41206361742074686174e280997320737475636b206f6e20746865204d6f6f6e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suipump.meme/uploads/MUNCAT_TJ_44_MB_FKFM_8_Y8eyh_H2_bbfd1cc1e2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

