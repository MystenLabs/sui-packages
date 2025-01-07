module 0xef550f5737aebe713363e51f72a4b75718f9d0899de597e76c23f1ea4757e997::xyo {
    struct XYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XYO>(arg0, 6, b"Xyo", b"TrumpX", b"Trump is leadong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Main_warth_herd_61f606d64c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

