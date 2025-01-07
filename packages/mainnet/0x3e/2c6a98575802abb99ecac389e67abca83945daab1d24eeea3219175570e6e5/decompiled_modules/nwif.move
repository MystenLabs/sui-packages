module 0x3e2c6a98575802abb99ecac389e67abca83945daab1d24eeea3219175570e6e5::nwif {
    struct NWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: NWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NWIF>(arg0, 6, b"NWIF", b"NeiroWifHat", x"4e6569726f57696648617420287469636b65723a20244e574946290a546865205265616c204e6569726f57696648617420244e574946202c2057686174206973204e5749463f204e574946206973204c6c69746572616c6c79206a7573742061204e6569726f20576966204120486174202120496620796f75206d6973736564206f7574206f66204e6569726f202f20574946207468616e2068657265206973207365636f6e64206368616e6365202120446f6e2774206d697373206f7574206f6e20244e5749462c205468697320697320796f757220564950207061737320746f20746865204d6f6f6e202c20576f6f6620576f6f66", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_UM_49_L2b_KC_Kbhqz_Fkc_DE_1px_T1_Z198o86a4x_P6_BQT_Di8i_F_7c13685422.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

