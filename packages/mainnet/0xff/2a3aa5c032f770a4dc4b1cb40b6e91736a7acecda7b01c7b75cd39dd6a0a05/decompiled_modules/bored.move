module 0xff2a3aa5c032f770a4dc4b1cb40b6e91736a7acecda7b01c7b75cd39dd6a0a05::bored {
    struct BORED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORED>(arg0, 6, b"BORED", b"Bored on sui", b"Getting sick of insider pumps and dumps, me too dev is bored and if you are too come chill and build up the community together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Nu_SCP_1_Tm_Z7rj_Fr4_Gj_RW_St55ua_HRDN_1xa_Hi_Dj2i_VW_5a_CE_fc4935af5b.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORED>>(v1);
    }

    // decompiled from Move bytecode v6
}

