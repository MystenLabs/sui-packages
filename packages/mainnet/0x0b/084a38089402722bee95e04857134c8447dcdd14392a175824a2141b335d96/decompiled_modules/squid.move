module 0xb084a38089402722bee95e04857134c8447dcdd14392a175824a2141b335d96::squid {
    struct SQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUID>(arg0, 6, b"SQUID", b"SUISQUID", b"Welcome to the world of SuiSquid, the friendliest memecoin on the Sui Chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suisquid_040ecd39ea_6985242b55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

