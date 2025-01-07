module 0x459e2e2e49efef48bb4137d256f17289e5a7d874197f6a0407b9a7dc92ee40c4::zip {
    struct ZIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIP>(arg0, 6, b"ZIP", b"ZIP SUI", b"ZIPUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_59_c7ffc0dac6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

