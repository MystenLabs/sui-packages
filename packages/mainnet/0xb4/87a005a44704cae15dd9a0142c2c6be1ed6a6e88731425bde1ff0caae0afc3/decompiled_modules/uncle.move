module 0xb487a005a44704cae15dd9a0142c2c6be1ed6a6e88731425bde1ff0caae0afc3::uncle {
    struct UNCLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNCLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNCLE>(arg0, 6, b"UNCLE", b"UNCLE CZ ON SUI", b"UNCLE SAY : \"BUILD ON SUI\" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_sui_ce79c4f4d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNCLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNCLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

