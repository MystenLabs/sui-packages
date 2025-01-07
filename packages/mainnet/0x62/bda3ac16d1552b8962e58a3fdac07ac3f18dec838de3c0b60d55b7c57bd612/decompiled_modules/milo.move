module 0x62bda3ac16d1552b8962e58a3fdac07ac3f18dec838de3c0b60d55b7c57bd612::milo {
    struct MILO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILO>(arg0, 6, b"Milo", b"suiRATT", b"meet Milo the suiratt from the block chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_28_b03247fe01.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILO>>(v1);
    }

    // decompiled from Move bytecode v6
}

