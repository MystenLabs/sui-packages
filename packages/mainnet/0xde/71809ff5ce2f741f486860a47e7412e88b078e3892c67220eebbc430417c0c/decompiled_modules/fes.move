module 0xde71809ff5ce2f741f486860a47e7412e88b078e3892c67220eebbc430417c0c::fes {
    struct FES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FES>(arg0, 6, b"FES", b"FLAT EARTH SUI", b"Flat Earth Is Truth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000127_3db2dc23bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FES>>(v1);
    }

    // decompiled from Move bytecode v6
}

