module 0x8f0310effc8419714724375964ebdead1e0250ba4c9fec33bc8891c992159292::baacto {
    struct BAACTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAACTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAACTO>(arg0, 6, b"BaaCTO", b"BAA Sheep CTO", b"Baa the sheep is making a comebaaack. Baaaauy some more while we send this to baaallions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TO_Kl_M0pl_400x400_e5d2466b05.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAACTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAACTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

