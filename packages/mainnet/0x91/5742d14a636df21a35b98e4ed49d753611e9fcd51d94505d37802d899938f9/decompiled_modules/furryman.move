module 0x915742d14a636df21a35b98e4ed49d753611e9fcd51d94505d37802d899938f9::furryman {
    struct FURRYMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURRYMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FURRYMAN>(arg0, 6, b"FURRYMAN", b"Furryman", x"46555252594d414e202d20546865204f472046657272796d616e205061792063727970746f20746f207468652046757272796d616e2028616b61207468652046657272796d616e2920616e642063726f737320746f2061667465726c696665202856616c68616c61292e2e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_TFS_27g2z785r_Uw8_Rva_Nue_P4t3_Ho9k_Atg_L9_Q_We3cgsa7t_ac0955b32b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURRYMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FURRYMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

