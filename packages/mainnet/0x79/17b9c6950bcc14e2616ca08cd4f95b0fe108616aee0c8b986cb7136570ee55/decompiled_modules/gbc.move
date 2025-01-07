module 0x7917b9c6950bcc14e2616ca08cd4f95b0fe108616aee0c8b986cb7136570ee55::gbc {
    struct GBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBC>(arg0, 6, b"GBC", b"baybygbc", b"Providing a comprehensive digital currency based on digital currencies to support sustainable growth in the mobile phone and accessories sector, while providing innovative financial services to users and businesses in Kuwait and the Gulf market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/22_472b44f41e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

