module 0x8da83a75c9d781588f02759f1068646534bcc550098be0c893a6a7eb191c1108::suipepe {
    struct SUIPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEPE>(arg0, 6, b"SUIPEPE", b"SuiPePe", b"PEPE, living on the SUI planet,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2323_1c44c6134d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

