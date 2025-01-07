module 0x12c662161b9e23c45807479846d3fd7fa5191eb31e867866d76060a3f3f0848f::quantroot {
    struct QUANTROOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANTROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANTROOT>(arg0, 6, b"QUANTROOT", b"QUANT ROOTLET", x"4375746520637265617475726573206861766520636f6d652066726f6d2074686520537569766572736520746f20636f6c6f6e697a6520456172746821204765742072656164792c206c65747320726f6f74210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticker_62499540af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANTROOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUANTROOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

