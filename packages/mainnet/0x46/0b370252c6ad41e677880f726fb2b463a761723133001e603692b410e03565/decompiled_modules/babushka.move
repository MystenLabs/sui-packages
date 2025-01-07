module 0x460b370252c6ad41e677880f726fb2b463a761723133001e603692b410e03565::babushka {
    struct BABUSHKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABUSHKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABUSHKA>(arg0, 6, b"BABUSHKA", b"BabushkaonSui", b"Making our babushkas proud and happy. 24/7 livestream of the dev from the babushka's farm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vcx5_Rot_Qce_CYVG_Xv5x_SP_4_KJW_Ry_Me927srxa_UU_Sn_HJZ_Po_fdd3e51942.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABUSHKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABUSHKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

