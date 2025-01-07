module 0x885dbaf06735ef2d52f57d8ac378433857db0e1115628ebdc66cd0cca8ca7b8c::atlas {
    struct ATLAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATLAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATLAS>(arg0, 6, b"ATLAS", b"New seaworld penguin", b"https://x.com/SeaWorld/status/1846220310284026141", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_X4_Pg6wux2_Pwar_F_Wk_Ro2_H_Bxy_Sne_T_Bmo_By_Sv_Emjv5c_P2zw_5189180956.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATLAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATLAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

