module 0x81dbdca3d017449f9163d7073405a2d072aeb7f4fc9e9c4f20a231d1123868a8::causa {
    struct CAUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAUSA>(arg0, 9, b"CAUSA", b"Causa Sui", b"Ex Unitae Vires - Ens Causa Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://7lpuz5ioxo6kmtna3on4kysit7jx2ytogr72fugh7ao72d5gyhyq.arweave.net/-t9M9Q67vKZNoNubxWJIn9N9Ym40f6LQx_gd_Q-mwfE?ext=jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAUSA>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAUSA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAUSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

