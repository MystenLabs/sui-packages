module 0x903c626267ef5db286566b3079a84d53fc030eb2c90254ec538a4e9962787932::suimui {
    struct SUIMUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMUI>(arg0, 6, b"SUIMUI", b"Sui to Moony", b"We sent Sui to the Moony", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/idta_J_Wxa_Xo_logos_1456e5c1cf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

