module 0x467d1757924744b37f19c17476bf19b154052874449b4b870269a9d14f93984e::RDF {
    struct RDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDF>(arg0, 6, b"Red Dragon Fire", b"RDF", x"4120626c617a696e6720686f74206d656d6520636f696e20696e73706972656420627920746865206d7974686963616c2072656420647261676f6e2e2052444620697320616c6c2061626f757420706f7765722c2070617373696f6e2c20616e642065706963206761696e732e204a6f696e2074686520666972652d627265617468696e6720636f6d6d756e69747920616e6420776174636820796f757220706f7274666f6c696f2069676e6974652120f09f94a5f09f9089", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/GsMm8zucd2rJJdgNgbThneKIAiepfIa1fCTcSkToMkCQS8XUB/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDF>>(v0, @0xdfbc0bca5f7ab287e65359124a2abf5cad98f8b6b7624819a650050338195689);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

