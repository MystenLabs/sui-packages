module 0x627d736098ca3bcf27e1a0a6ca9cfb4a5cd816712a614fa79385524fa0bee379::caf {
    struct CAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAF>(arg0, 6, b"CAF", b"Cigarette After Sex", b"CAF - feel the pleasure of cigarettes after sex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002124_bf6d3a7f42.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

