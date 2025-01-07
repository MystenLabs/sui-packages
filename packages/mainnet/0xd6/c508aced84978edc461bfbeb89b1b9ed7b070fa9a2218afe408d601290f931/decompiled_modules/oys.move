module 0xd6c508aced84978edc461bfbeb89b1b9ed7b070fa9a2218afe408d601290f931::oys {
    struct OYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OYS>(arg0, 6, b"OYS", b"Oysti and his Precious Pearl", b"Oysti and his Precious Pearl, the most dazzling gem in all of the SUI Sea! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x0f0803f148a27b1a8e20f45a68c9e2a9965e994e947780a96000e7077d3bb9c3_oysti_oysti_6c86a63a3c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

