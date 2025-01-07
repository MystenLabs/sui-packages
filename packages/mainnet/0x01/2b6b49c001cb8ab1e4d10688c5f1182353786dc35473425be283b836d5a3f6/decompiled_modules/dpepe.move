module 0x12b6b49c001cb8ab1e4d10688c5f1182353786dc35473425be283b836d5a3f6::dpepe {
    struct DPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPEPE>(arg0, 6, b"DPEPE", b"DumblePepe", b"WINGARDIUM PEPIOSA  DumblePepe ($DPEPE)  The Wizard of Memecoins! Magic, memes & moonshots. Join the spellbound journey to $100M MC! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_UN_4_CC_5_S12_Nk_Tb_Zw1iqqn_Dp_C55_Eh_YADP_Yb_X5tz_Dn_Ntqv9_062de2ebe5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

