module 0x3ce4d76bb922fb146b85015dbe967d948c43e7924c4989f04ce4f0fc4872345c::pwig {
    struct PWIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWIG>(arg0, 6, b"PWIG", b"Pwig", b"IS THAT A PEPE? IS THAT A PIG? IT LOOKS LIKE A PWIG!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pwig_c40a79b79f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

