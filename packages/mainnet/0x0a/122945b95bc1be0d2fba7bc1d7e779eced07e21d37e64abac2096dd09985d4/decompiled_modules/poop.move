module 0xa122945b95bc1be0d2fba7bc1d7e779eced07e21d37e64abac2096dd09985d4::poop {
    struct POOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOP>(arg0, 6, b"POOP", b"POOP SUI", b"POOP ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/poop_f5e0cfc26e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

