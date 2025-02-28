module 0x2064b1cce78ea9c344c586b3bac6346fcad1c6f5d38261a7a51a43f30f30a1e3::sea {
    struct SEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEA>(arg0, 6, b"SEA", b"SEA URCHINS", b"I will spread my thorns to everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000104196_59c8203dea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

