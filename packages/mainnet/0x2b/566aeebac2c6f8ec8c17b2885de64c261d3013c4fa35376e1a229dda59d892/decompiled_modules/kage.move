module 0x2b566aeebac2c6f8ec8c17b2885de64c261d3013c4fa35376e1a229dda59d892::kage {
    struct KAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAGE>(arg0, 6, b"KAGE", b"kage.sui", x"46726f6d2074686520736861646f777320776520726973652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TX_4_a_Cbx_400x400_7a5913c11f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

