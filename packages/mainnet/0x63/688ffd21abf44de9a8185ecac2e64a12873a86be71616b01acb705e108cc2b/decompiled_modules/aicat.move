module 0x63688ffd21abf44de9a8185ecac2e64a12873a86be71616b01acb705e108cc2b::aicat {
    struct AICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AICAT>(arg0, 6, b"AICAT", b"AI Cat", b"First AI Cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000057641_eb908e2489.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AICAT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AICAT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

