module 0xbdf420419146d18ab1057b054397913009eae00a7fec242097941cdec0b155c0::aaaaaaaa {
    struct AAAAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAAAAA>(arg0, 6, b"AAAAAAAa", b"AAAAAa", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_N_D_N_D_D_D_2024_10_17_234624_ee3964b9f6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAAAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAAAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

