module 0x6bf718047e65792fffafc215406898615b51637b49b811cfd0060778325e63e6::rcoon {
    struct RCOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCOON>(arg0, 6, b"RCOON", b"RACCOONS ON SUI", b"$RCOON - The Raccoons on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dlh_I_Ml_Uf_400x400_d329db6629.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RCOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

