module 0x58696f6d77659f92e42e92097030a5878cb1b42aaece5e73c71b9d7edcf823db::catmas {
    struct CATMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATMAS>(arg0, 6, b"CATMAS", b"Meowy Catmas", x"4361746d617320746865204368726973746d617320737069726974207769746820636174206d656d65732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_RDAN_76_FDM_Gbzvn_Dpou_XXEJV_Dc9_P2u5_Jv_Snvcxx_Qg_Yce_72906588a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

