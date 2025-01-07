module 0x74a001a6400175005c1941e6035b9e8bc1781cdd469d08133f94b6d9232fc2f3::dogpus {
    struct DOGPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGPUS>(arg0, 6, b"Dogpus", b"Octopus Dog", b"Meet Oscar he's a funny dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003617_776f0eb88f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

