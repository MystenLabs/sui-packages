module 0xce228ce1e4f8988d8c5529af6dbc823f10bae49d5c15c12d165c1badc89890ed::bicoin {
    struct BICOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BICOIN>(arg0, 6, b"BICOIN", b"B1COIN", x"4231434f494e20697320746865206d6f73742062756c6c69736820262066756e20636f6d6d756e6974792d64726976656e206d656d65636f696e2077697468204c616d626f726768696e6920234c616d62696e6720726166666c657320616d6f6e6720686f6c646572732e204275792c207374616b6520262077696e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BICOIN_T_Jv_Qm_L_cp_Zkc8s_Ga_Ku_C_8384543515.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BICOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BICOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

