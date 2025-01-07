module 0xc530ae5ae1b98f9233bc14a84951e0ddddec08f3310315315cd759baa6327ce8::ltcwif {
    struct LTCWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTCWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTCWIF>(arg0, 6, b"LTCWIF", b"Litecoin Wif Hat", b"Litecoin is now identifying as a memecoin per official announcement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731609262777.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LTCWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTCWIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

