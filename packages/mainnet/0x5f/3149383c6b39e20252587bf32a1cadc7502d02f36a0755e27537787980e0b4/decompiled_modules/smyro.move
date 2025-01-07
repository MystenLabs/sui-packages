module 0x5f3149383c6b39e20252587bf32a1cadc7502d02f36a0755e27537787980e0b4::smyro {
    struct SMYRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMYRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMYRO>(arg0, 6, b"SMYRO", b"MYRO ON SUI", b"myro on sui block chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/28382_logo_62bae4bca2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMYRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMYRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

