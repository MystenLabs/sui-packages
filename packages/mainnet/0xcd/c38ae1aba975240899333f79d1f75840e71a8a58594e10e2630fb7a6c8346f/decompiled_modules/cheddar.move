module 0xcdc38ae1aba975240899333f79d1f75840e71a8a58594e10e2630fb7a6c8346f::cheddar {
    struct CHEDDAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEDDAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEDDAR>(arg0, 6, b"CHEDDAR", b"BLUE CHEESE", b"CHEESE ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/blue_cheese_logo_f8b73fe5f3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEDDAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEDDAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

