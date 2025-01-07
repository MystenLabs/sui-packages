module 0x8e50a4eed77765656bfab547df192a7ec31cdedd7eeec4d05d0a3ef949f15478::owa {
    struct OWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWA>(arg0, 6, b"OWA", b"OwangeSui", b"you will not find a human like me in any other human, don't miss out on your first owange. Bound 100% ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asddd_528ad8c4ab.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

