module 0x4c7bc4398459334b81f057249e056bdaafcadcdef25800ef08525c40b7b2fd2e::axo {
    struct AXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXO>(arg0, 6, b"AXO", b"Axo", b"Axo the axolotl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AXO_eced7e4d3b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXO>>(v1);
    }

    // decompiled from Move bytecode v6
}

