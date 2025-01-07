module 0xf801cf16625c71115fc28f3562a63d778a713e1d1307ec4ee90d27f826f44f3a::ken {
    struct KEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEN>(arg0, 6, b"KEN", b"Sui Ken", b"Ken is a based little chicken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_09_16_T201428_175_bd3e4d99cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

