module 0xcc898e3f3b9f4e5a874c85a6b77e4b1ed50f894bef2e4130355516436041e192::superman {
    struct SUPERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERMAN>(arg0, 6, b"SUPERMAN", b"SUPERMAN A HERO", b"A symbol of hope arrives", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ru_X_Xt_Q5e_400x400_483751ecf0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

