module 0x55479e8617a7f8250807f71424abd0121b907cb55807cdae8673441fe05918ae::shorse {
    struct SHORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHORSE>(arg0, 6, b"SHORSE", b"SUIHORSE", b"riding the horse under the sui waters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_72_f1602774b2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHORSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHORSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

