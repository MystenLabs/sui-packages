module 0x9db1aa63b0e616181c955952fc977a9fb41d789b99ed6dc88cd593190490f7d5::crab {
    struct CRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAB>(arg0, 6, b"CRAB", b"Crabbie", x"54686520646567656e657261746520537569206d6f67756c2c2070696e63686572206f662063686172747320616e64206e6f726d6965730a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/VA_3_ZMQB_400x400_d56a88b92d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

