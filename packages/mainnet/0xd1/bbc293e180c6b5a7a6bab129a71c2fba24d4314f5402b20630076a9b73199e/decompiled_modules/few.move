module 0xd1bbc293e180c6b5a7a6bab129a71c2fba24d4314f5402b20630076a9b73199e::few {
    struct FEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEW>(arg0, 6, b"FEW", b"Frozen Eternity Water", b"If you understand what this is, we are the same", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_114345ba41.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

