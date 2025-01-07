module 0x6fac48e20eaab46017172347331dd139b9d1810c72a05dd2df5661d442cac680::ripsol {
    struct RIPSOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIPSOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIPSOL>(arg0, 6, b"RIPSOL", b"RIPRIPSOL", b"SOL is dead,SUI is solana killer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12_DEE_36_C_8220_472_D_B06_D_E515249_ADA_68_ca90976d88.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIPSOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIPSOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

