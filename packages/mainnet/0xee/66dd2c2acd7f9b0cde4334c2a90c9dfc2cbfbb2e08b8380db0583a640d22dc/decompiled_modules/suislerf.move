module 0xee66dd2c2acd7f9b0cde4334c2a90c9dfc2cbfbb2e08b8380db0583a640d22dc::suislerf {
    struct SUISLERF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISLERF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISLERF>(arg0, 6, b"SUISLERF", b"Sui Slerf", x"486920496d20612053756920536c65726620616e6420496d206120666972737420736c6f7468206f6e204d6f766570756d702e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_c17a67377d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISLERF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISLERF>>(v1);
    }

    // decompiled from Move bytecode v6
}

