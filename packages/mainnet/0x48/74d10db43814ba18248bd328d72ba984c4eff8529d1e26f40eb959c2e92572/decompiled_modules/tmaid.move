module 0x4874d10db43814ba18248bd328d72ba984c4eff8529d1e26f40eb959c2e92572::tmaid {
    struct TMAID has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMAID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMAID>(arg0, 6, b"TMAID", b"Marmaid tate", b"its me here on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GG_Hs_Rq_W8_A_Ec_U_z_682b24e98e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMAID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TMAID>>(v1);
    }

    // decompiled from Move bytecode v6
}

