module 0x80a98fd48cb7a31f22a11de2001705762581a041e12aebfa5e2f8e837bc470e6::axo {
    struct AXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXO>(arg0, 6, b"AXO", b"Axo", b"Axo the Axolotl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AXO_81339b61fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXO>>(v1);
    }

    // decompiled from Move bytecode v6
}

