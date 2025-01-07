module 0x7639b29101e2ed2fc83e17483d3c1bf95cc72b53e8cb9d0dcb72c87d9f8c529b::onxe {
    struct ONXE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONXE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONXE>(arg0, 6, b"ONXE", b"ONXE SUI", b"First ONXE on SUI:https://onxeonsui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/VREC_7_FSP_400x400_52d6d1fbdf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONXE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONXE>>(v1);
    }

    // decompiled from Move bytecode v6
}

