module 0xb3e3fa7405898b30295f7b723e303fa3fd06d4cb002bcc92be5a4e1fea34f30::suirca {
    struct SUIRCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRCA>(arg0, 6, b"SUIRCA", b"Sui Orca", b"Meet $SUIRCA, The apex predator of the Sui waters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_91_0e18e5e2da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

