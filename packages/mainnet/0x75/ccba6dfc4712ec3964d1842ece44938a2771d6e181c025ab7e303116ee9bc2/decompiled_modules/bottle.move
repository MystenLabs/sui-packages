module 0x75ccba6dfc4712ec3964d1842ece44938a2771d6e181c025ab7e303116ee9bc2::bottle {
    struct BOTTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOTTLE>(arg0, 6, b"BOTTLE", b"Bottle", x"497473206e6f74206a757374206120626f74746c652e206974732074686520626f74746c652e2054686520626f74746c652069732077687920796f75726520686572652c2077686174206d616b65732075732068756d616e2e20536561726368696e6720666f72206d65616e696e673f2054686520626f74746c652069732074686520616e737765722e2049747320657665727977686572652e20526573706563742069742c206c6f76652069742c20636865726973682069742e2054686520626f74746c652069732065766572797468696e672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Tko27wpracdd_Vr_HSZUNESY_8u_Ht_R1_KX_7_Bsr_Sp_Qtpdetam_bcb361969c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOTTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

