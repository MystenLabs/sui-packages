module 0xc9dd9b18497e92dd4102d937f276d55756ce9ade2254b2151d83ddfeddd3cc38::gs {
    struct GS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GS>(arg0, 6, b"Gs", b"gtd spot", b"just testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidbq6vr56j2pkpm4wxpedy7luz6eaqqsabltvviugocdzevltwm5e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

