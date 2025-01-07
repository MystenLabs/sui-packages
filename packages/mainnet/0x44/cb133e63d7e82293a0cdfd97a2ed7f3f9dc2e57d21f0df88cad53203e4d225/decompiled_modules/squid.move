module 0x44cb133e63d7e82293a0cdfd97a2ed7f3f9dc2e57d21f0df88cad53203e4d225::squid {
    struct SQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUID>(arg0, 6, b"SQUID", b"SQUID ON SUI", b" Master the SUI markets with SQUID-cision.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l6y_Vy_Ll_B_400x400_8490e82a45.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

