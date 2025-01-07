module 0x967e936560570a10f04bab46319f2669db99eec2293afbc8e06771812d44c30c::bobo {
    struct BOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBO>(arg0, 6, b"BOBO", b"Bobo", x"5468652042656172206f662074686520426c6f636b636861696e200a0a24424f424f2069732074686520756c74696d617465206d656d6520636f696e20726f6172696e6720746f206c696665206f6e207468652053756920626c6f636b636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/I3my_T7d0_400x400_removebg_preview_1_963ec3146e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

