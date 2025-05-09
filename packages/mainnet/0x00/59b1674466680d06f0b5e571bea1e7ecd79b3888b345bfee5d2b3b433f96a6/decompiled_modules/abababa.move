module 0x59b1674466680d06f0b5e571bea1e7ecd79b3888b345bfee5d2b3b433f96a6::abababa {
    struct ABABABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABABABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABABABA>(arg0, 6, b"ABABABA", b"ABALA", b"ABBABABA ABABABABBAA ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_sui_logo_e0a1bd9952.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABABABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABABABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

