module 0x3810ebd0679393e12113e1025b8f553ff325b9c6d45e54deb66a92124f7a1e45::smole {
    struct SMOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOLE>(arg0, 6, b"SMOLE", b"smolecoin", x"736d6f6c65636f696e2028534d4f4c45290a6120736d6f6c206d6f6c6520616e642074686520736d6f6c6c65737420736d6f6c65636f696e20696e2074686520736d6f6c616e612073756920736d6f6c6e65742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11_dcb8ce11f6.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

