module 0xd651b1e15f0eb0106d097d68961f6113861d78489f23d904516c2c59f9c8e106::graph {
    struct GRAPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAPH>(arg0, 6, b"GRAPH", b"MR.GRAPH", b"https://mrgraphitosol.xyz/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_19_57_50_2_306f7af249.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRAPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

