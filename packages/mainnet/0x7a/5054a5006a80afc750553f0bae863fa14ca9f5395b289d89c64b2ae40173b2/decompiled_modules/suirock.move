module 0x7a5054a5006a80afc750553f0bae863fa14ca9f5395b289d89c64b2ae40173b2::suirock {
    struct SUIROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIROCK>(arg0, 6, b"SUIROCK", b"Sui Rock", b"just a rock on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MICKY_10_71819c76fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

