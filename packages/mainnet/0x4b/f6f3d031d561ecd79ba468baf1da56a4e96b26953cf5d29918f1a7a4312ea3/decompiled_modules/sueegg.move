module 0x4bf6f3d031d561ecd79ba468baf1da56a4e96b26953cf5d29918f1a7a4312ea3::sueegg {
    struct SUEEGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUEEGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUEEGG>(arg0, 6, b"SUEEGG", b"World_Record_Sui_Egg", b"Most famous egg on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/world_f55d845544.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUEEGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUEEGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

