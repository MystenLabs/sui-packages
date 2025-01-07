module 0x5a110919f89364df26e0d2d2f81556bf257cf1c0393151cecd98d33a4765752c::suipitu {
    struct SUIPITU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPITU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPITU>(arg0, 6, b"SUIPITU", b"Suipitu", b"No dev, dev is a pitu.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/W_My8_fd7c8256d6.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPITU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPITU>>(v1);
    }

    // decompiled from Move bytecode v6
}

