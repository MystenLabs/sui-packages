module 0xfabba9bfd78ad77b893f81774fbe08dd54ac29d9ffcb6322c5a0e85a13f4aafc::suido {
    struct SUIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDO>(arg0, 6, b"SUIDO", b"SUIDOWOODO", b"To avoid being attacked, it does nothing but mimic a tree. It loves water. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suidowodo_floating_765a66b9ea.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

