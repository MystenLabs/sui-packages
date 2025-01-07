module 0x1847828ee77c29a85bf5f215d10f2a2fed8dde243018bec611b276cf364a86d0::trumptardio {
    struct TRUMPTARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPTARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPTARDIO>(arg0, 6, b"Trumptardio", b"Trumptardio on sui", b"The first Trumptardio on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/15i_P_Ag_U_400x400_e10625e869.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPTARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPTARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

