module 0x48ee79a5c2626a9f560e2338429943076e8933269192b688b3ad7f7e86ae3881::chewy {
    struct CHEWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEWY>(arg0, 6, b"CHEWY", b"CHEWYonSUI", b"$CHWY  a community coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mz_W_Kl_Cvm_400x400_1626164c07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEWY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

