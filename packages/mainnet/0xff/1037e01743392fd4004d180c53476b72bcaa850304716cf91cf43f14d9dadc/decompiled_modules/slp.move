module 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::slp {
    struct SLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLP, arg1: &mut 0x2::tx_context::TxContext) {
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::create_admin_cap(arg1);
        let (v0, v1) = 0x2::coin::create_currency<SLP>(arg0, 6, b"SLP", b"Sudo LP Token", b"LP Token for Sudo Market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/_SEJoeyOw0uVJbu-kcJZ1BFP1E5j4OWOdQnv4s51rU0")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLP>>(v1);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::create_market<SLP>(0x2::coin::treasury_into_supply<SLP>(v0), 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_percent(5), arg1);
    }

    // decompiled from Move bytecode v6
}

