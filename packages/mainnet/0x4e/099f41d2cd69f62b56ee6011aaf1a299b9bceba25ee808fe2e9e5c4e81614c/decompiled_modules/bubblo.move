module 0x4e099f41d2cd69f62b56ee6011aaf1a299b9bceba25ee808fe2e9e5c4e81614c::bubblo {
    struct BUBBLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLO>(arg0, 6, b"BUBBLO", b"BUBBLO SUI", b"Drifting droplet with zero sense of direction $BUBBLO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2si_NVXDL_6_Zh585_S_Phv_Ua6_Va8_G_Tbhb_Toq_Xz_Ubnp_Eppump_4400849b1e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

