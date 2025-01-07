module 0x9e11cee10b47cff1fd6eedfcf8c3e7fad03d7ce6478789c6fb5ec90fe463b892::poof_on_sui {
    struct POOF_ON_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOF_ON_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOF_ON_SUI>(arg0, 9, b"POOF ON SUI", b"POOFED", b"poofed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POOF_ON_SUI>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOF_ON_SUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOF_ON_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

