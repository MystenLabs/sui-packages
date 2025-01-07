module 0x958ecde750db26f497885ad1fac8684be9df25c176350e1bfc1a4a1ae2c129a0::babyducky {
    struct BABYDUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYDUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYDUCKY>(arg0, 6, b"Babyducky", b"Baby Ducky on Sui", b"original tokens.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FY_Cu_Z_Rt_UUAAZP_1i_69e6f51623.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYDUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYDUCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

