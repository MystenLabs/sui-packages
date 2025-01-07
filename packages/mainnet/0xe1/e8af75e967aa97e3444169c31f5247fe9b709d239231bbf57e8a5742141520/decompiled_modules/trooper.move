module 0xe1e8af75e967aa97e3444169c31f5247fe9b709d239231bbf57e8a5742141520::trooper {
    struct TROOPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROOPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROOPER>(arg0, 6, b"TROOPER", b"Trooper", b"Trooper ($TROOPER) is a Sui-based meme coin inspired by the heroic rescue of a dog named Trooper, saved from Hurricane Milton by the Florida Highway Patrol. Troopers story represents survival, resilience, and the kindness of humanity towards abandoned animals. The purpose of $TROOPER is to raise awareness and funds for animal rescue organizations, with a percentage of the token supply dedicated to shelters, including those involved in disaster response and animal welfare. We have reached out to the Leon County Humane Society, the shelter that took in Trooper, to form an official partnership. The dev wallet with 3% of the total supply will be allocated to a charity wallet that will be used to fund donations over time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ri_E_Vit_Zh_Ph_Zdh_C_Gp_Hr4_M_Te8_Gq_Vn_Sd_Pn_W_Dw_X_Fz_Hn_FV_Bny_9bc71b00bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROOPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROOPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

