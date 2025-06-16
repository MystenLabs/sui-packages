module 0xcce347a42ec9fbc653a3de5e262710d26f07664655ce5949bbaab639f1d8f6b2::haircut {
    struct HAIRCUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAIRCUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAIRCUT>(arg0, 6, b"Haircut", b"lion with haircut", b"Because even kings of the jungle know the importance of a good barbershop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_c30b8bb8a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAIRCUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAIRCUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

