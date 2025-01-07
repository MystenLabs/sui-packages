module 0x56bc892d6276c32d33aacbb7b1dd28f680c90e5f1716a4096d3da56fdc0d4e6e::axo {
    struct AXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXO>(arg0, 6, b"AXO", b"SUI AXOLOTL", b"AXOLOTL IN SU I UNIVERSE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/original_43e48c81292464f78b2a85e87046d9a8_29f7fc6d8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXO>>(v1);
    }

    // decompiled from Move bytecode v6
}

