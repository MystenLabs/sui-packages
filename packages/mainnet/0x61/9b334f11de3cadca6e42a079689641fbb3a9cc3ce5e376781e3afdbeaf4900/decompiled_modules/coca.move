module 0x619b334f11de3cadca6e42a079689641fbb3a9cc3ce5e376781e3afdbeaf4900::coca {
    struct COCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCA>(arg0, 6, b"COCA", b"COCA LEAF", b"COCA LEAF IS GOOD FOR EVERYONE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coca_bbe2c7fa20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

