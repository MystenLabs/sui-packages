module 0x4f9e4eaacbfef584aa7781609d8fbaa591d83d20a667a410a25a420ba7c3684c::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 6, b"FISH", b"TFISH", b"Fish's mission is to provide you with a better future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950327283.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

