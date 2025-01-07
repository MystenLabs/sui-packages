module 0x5a323b061b6f3b1b007447b764f6decc9cebb3cb8f78889dcd2f7225b60e9fb0::rino {
    struct RINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RINO>(arg0, 6, b"RINO", b"SUI RINO", b"Memecoin - Hamster $RINO Gaga's best friend $GAGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/oe_Fj_Tz_HO_400x400_160b2c6e53.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

