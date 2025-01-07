module 0x82906c0265ffaf406e1f57db786a7e90f2b838132f9813989f48d093c10ddbf8::mudkip {
    struct MUDKIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUDKIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUDKIP>(arg0, 6, b"MUDKIP", b"MudkipOnSui", b"Cutest Mudkip is launch on #Sui bluppp bluppp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953868044.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUDKIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUDKIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

