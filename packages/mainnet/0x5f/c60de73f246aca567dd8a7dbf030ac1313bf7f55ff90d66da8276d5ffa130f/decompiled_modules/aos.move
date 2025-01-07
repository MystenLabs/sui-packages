module 0x5fc60de73f246aca567dd8a7dbf030ac1313bf7f55ff90d66da8276d5ffa130f::aos {
    struct AOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AOS>(arg0, 6, b"AOS", b"AVATAR ON SUI", b"AVATAR ON SUI NEW HOPE NEW LIFE!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_3_241c00a372.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

