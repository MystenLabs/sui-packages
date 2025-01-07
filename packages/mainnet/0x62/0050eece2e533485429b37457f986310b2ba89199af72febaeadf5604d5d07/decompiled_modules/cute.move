module 0x620050eece2e533485429b37457f986310b2ba89199af72febaeadf5604d5d07::cute {
    struct CUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUTE>(arg0, 6, b"CUTE", b"Unknown Animal", b"Cute unknown Animal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2254_12fdd5ac02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

