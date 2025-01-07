module 0x326d1541557df808501107ab083a0b561b0b365fe9934bff5f56cc6e7247d0a6::famouscapybara {
    struct FAMOUSCAPYBARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAMOUSCAPYBARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAMOUSCAPYBARA>(arg0, 6, b"FamousCapybara", b"CINNAMON", b"World's Most Famous Capybara", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QJ_54phug1_Eq_Bq9_YWD_8_QN_Pzie_Vu4j_F_Snfme_Whh_Xiyjf_BP_7db626b675.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAMOUSCAPYBARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAMOUSCAPYBARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

