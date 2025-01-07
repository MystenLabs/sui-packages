module 0x27ddd5e2dea09544a55452c3f5a50c0cce8da7a9b903767c9ad84cbbe5b31cfe::wp {
    struct WP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WP>(arg0, 6, b"WP", b"Wealthy Pudgy", x"5765616c746879205075646779207468726f77696e672061726f756e64206869732063617368210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SD_5_Ctpq_BERY_Ev_Ph_ZMDXVW_62_Lwt_Tr_W_Cvno_Ez7a_XE_Crw_ME_702b95cf7d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WP>>(v1);
    }

    // decompiled from Move bytecode v6
}

