module 0xfba08fa7c8e2a1c7a335c0940013704e651b4a322df6f4b7a9fc984e4bcf4c78::dorkl {
    struct DORKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORKL>(arg0, 6, b"DORKL", b"DorkLord", b"The Dork Lord of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dorklogo_e5b4f44175.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

