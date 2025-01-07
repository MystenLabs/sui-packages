module 0x3aee774fa717788642c167676236fb9e52e3a8f91756031481fc675aa3476cf3::bary {
    struct BARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARY>(arg0, 6, b"BARY", b"Bary the capybara", b"Bary is ready for an adventure!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_G81qsh5_X_Mo_Ss_Wm_Y_Kn_Sk_D7euc_LP_Kddo_T_Pg_W_Cn_Lo7ddd_T_49d33a7c2c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARY>>(v1);
    }

    // decompiled from Move bytecode v6
}

