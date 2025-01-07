module 0x898108dc6bdca64bae8cbfc0d175df5ddc0e74067268d9c49b5ca2297035409e::sfloki {
    struct SFLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFLOKI>(arg0, 6, b"SFLOKI", b"Floki On SUI", b"Floki on SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/floki_on_sui_logo_ef71734282.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFLOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFLOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

