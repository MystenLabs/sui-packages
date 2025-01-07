module 0xe4190bc1c7e3f0f486b7b916e323f43da22b9063fe51f398d7584abcf3950d6::ds {
    struct DS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DS>(arg0, 6, b"DS", b"DINO SUI", b"RAAWWRRR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_BLUE_938e8db2fe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DS>>(v1);
    }

    // decompiled from Move bytecode v6
}

