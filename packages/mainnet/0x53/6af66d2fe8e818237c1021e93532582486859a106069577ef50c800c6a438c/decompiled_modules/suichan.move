module 0x536af66d2fe8e818237c1021e93532582486859a106069577ef50c800c6a438c::suichan {
    struct SUICHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHAN>(arg0, 6, b"SUICHAN", b"SUI CHAN ON SUI CHAIN", b"A promise of mystery, a touch of grace", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/T4_TRKL_2_I_400x400_1_5fd5352189.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

