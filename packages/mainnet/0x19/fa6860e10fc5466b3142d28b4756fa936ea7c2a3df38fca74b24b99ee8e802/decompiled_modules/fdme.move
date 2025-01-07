module 0x19fa6860e10fc5466b3142d28b4756fa936ea7c2a3df38fca74b24b99ee8e802::fdme {
    struct FDME has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDME>(arg0, 6, b"FDME", b"Daram", b"Free mint+Defi+MemeFDME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R_Cvhgv_GU_400x400_8822407cdc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FDME>>(v1);
    }

    // decompiled from Move bytecode v6
}

