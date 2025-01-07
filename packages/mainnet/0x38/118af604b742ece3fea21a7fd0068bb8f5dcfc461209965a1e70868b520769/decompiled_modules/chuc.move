module 0x38118af604b742ece3fea21a7fd0068bb8f5dcfc461209965a1e70868b520769::chuc {
    struct CHUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUC>(arg0, 6, b"CHUC", b"Chuckle Cat", b"Chuckle Cat on SUI, here to have fun and explore space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_U_Uu35_P_Pe_Toz_Qjf8_Ja_Ev_H4r6qrx_Hy3ytzes_G_Du_W6rk2a_badff3296d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

