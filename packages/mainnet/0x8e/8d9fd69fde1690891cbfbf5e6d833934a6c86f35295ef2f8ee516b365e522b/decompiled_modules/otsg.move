module 0x8e8d9fd69fde1690891cbfbf5e6d833934a6c86f35295ef2f8ee516b365e522b::otsg {
    struct OTSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTSG>(arg0, 6, b"OTSG", b"one two Sui go", b"One, Two, Three, Go!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ore1_6997e367ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

