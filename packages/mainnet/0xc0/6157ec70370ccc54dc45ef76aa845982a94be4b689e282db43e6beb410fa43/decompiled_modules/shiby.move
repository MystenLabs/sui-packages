module 0xc06157ec70370ccc54dc45ef76aa845982a94be4b689e282db43e6beb410fa43::shiby {
    struct SHIBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBY>(arg0, 6, b"SHIBY", b"SHIBY on SUI", b"Community Owned CTO | Baby sister to the renowned", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u_A1_Nfng_V_400x400_8c907c7fd8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

