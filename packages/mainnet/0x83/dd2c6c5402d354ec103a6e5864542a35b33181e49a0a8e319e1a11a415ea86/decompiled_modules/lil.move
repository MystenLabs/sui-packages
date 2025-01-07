module 0x83dd2c6c5402d354ec103a6e5864542a35b33181e49a0a8e319e1a11a415ea86::lil {
    struct LIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIL>(arg0, 6, b"LIL", b"LIL SUI", b"Im a little sui Degen ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F5_C7_F7_BD_1_EDB_43_DB_85_F1_647_B535_F14_E1_8d164e207f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

