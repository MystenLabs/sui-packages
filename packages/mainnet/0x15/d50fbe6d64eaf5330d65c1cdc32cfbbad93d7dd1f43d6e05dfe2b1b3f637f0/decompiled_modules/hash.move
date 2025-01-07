module 0x15d50fbe6d64eaf5330d65c1cdc32cfbbad93d7dd1f43d6e05dfe2b1b3f637f0::hash {
    struct HASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASH>(arg0, 6, b"HASH", b"HASHOnSui", b"BECOME A HASHTRONAUT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241003_031722_ea5ab07374.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

