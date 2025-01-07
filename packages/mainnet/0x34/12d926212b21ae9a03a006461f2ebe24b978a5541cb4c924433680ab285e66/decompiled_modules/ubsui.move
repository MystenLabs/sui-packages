module 0x3412d926212b21ae9a03a006461f2ebe24b978a5541cb4c924433680ab285e66::ubsui {
    struct UBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UBSUI>(arg0, 6, b"UBSUI", b"Umbre Sui", x"245553554920697320676f696e6720746f2074616b65206f76657220746865206d656d6520737061636520696e20612073757270726973696e67207761792e20496620796f75206c6f766520556d627265206f6e205375692c20796f752063616e2062757920245553554920746f20737570706f7274206f75722070726f6a65637420746f20636f6e74696e756520746f2067726f770a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_3_2_34ddb11ec0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

