module 0xcaeeda70afd3a2ee4773d4aa437bead27311c15a542cde1567552a76334f87f8::suilley {
    struct SUILLEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILLEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILLEY>(arg0, 6, b"SUILLEY", b"Suilley", b"$SUILLEY - The perfect SUI mascot! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suilley_1_cb64f382e3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILLEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILLEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

