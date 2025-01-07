module 0x8a6a9fa8affdcd9b4f7a834b41bc26c990bc342401e440a9775c74c73163cf83::divorce {
    struct DIVORCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIVORCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIVORCE>(arg0, 6, b"DIVORCE", b"Wife Changing Money", b"Get it now, change her tonight ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIP_1_e0f1533597.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIVORCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIVORCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

