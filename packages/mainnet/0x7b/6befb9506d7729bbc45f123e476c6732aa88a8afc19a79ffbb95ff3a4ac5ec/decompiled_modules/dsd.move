module 0x7b6befb9506d7729bbc45f123e476c6732aa88a8afc19a79ffbb95ff3a4ac5ec::dsd {
    struct DSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSD>(arg0, 6, b"DSD", b"Sjdjd", b"Djejdh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012168_0768e0c230.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

