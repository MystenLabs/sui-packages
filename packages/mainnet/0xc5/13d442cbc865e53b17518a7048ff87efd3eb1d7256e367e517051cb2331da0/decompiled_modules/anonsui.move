module 0xc513d442cbc865e53b17518a7048ff87efd3eb1d7256e367e517051cb2331da0::anonsui {
    struct ANONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANONSUI>(arg0, 6, b"ANONSUI", b"Anonsui", b"Anonsui : We are not a team. We are not a project. We are a revolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053449_b604a337ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

