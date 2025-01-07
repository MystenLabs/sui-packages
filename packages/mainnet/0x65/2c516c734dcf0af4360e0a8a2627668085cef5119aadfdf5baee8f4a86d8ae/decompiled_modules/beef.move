module 0x652c516c734dcf0af4360e0a8a2627668085cef5119aadfdf5baee8f4a86d8ae::beef {
    struct BEEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEF>(arg0, 6, b"BEEF", b"Internet Beef", b"Internet Beef,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Nd_JSHA_5_Lt_Xu_Vqza73_CB_7zwv81_Co_B58n_M5kp_Ni_Jz_F2c_Kv_680d774635.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

