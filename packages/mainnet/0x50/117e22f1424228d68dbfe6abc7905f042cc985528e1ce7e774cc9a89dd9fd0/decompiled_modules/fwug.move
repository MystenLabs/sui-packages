module 0x50117e22f1424228d68dbfe6abc7905f042cc985528e1ce7e774cc9a89dd9fd0::fwug {
    struct FWUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWUG>(arg0, 6, b"FWUG", b"FWUG SUI", b"FWUG from SUI. Brother of Fwog and PEPE's good friend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_28_23_16_32_fa3184492c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

