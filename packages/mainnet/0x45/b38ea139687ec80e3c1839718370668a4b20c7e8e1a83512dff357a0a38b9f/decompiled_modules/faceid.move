module 0x45b38ea139687ec80e3c1839718370668a4b20c7e8e1a83512dff357a0a38b9f::faceid {
    struct FACEID has drop {
        dummy_field: bool,
    }

    fun init(arg0: FACEID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FACEID>(arg0, 6, b"FACEID", b"FACE ID", b"Unlock the canvas of identity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/V_Aw_Ziz_H2_400x400_1cad5a8183.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FACEID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FACEID>>(v1);
    }

    // decompiled from Move bytecode v6
}

