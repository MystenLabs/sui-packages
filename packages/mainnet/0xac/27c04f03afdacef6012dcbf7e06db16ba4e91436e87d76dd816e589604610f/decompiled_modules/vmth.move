module 0xac27c04f03afdacef6012dcbf7e06db16ba4e91436e87d76dd816e589604610f::vmth {
    struct VMTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: VMTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<VMTH>(arg0, 6, 0x1::string::utf8(b"VMTH"), 0x1::string::utf8(b"Velvet Moth"), 0x1::string::utf8(b"Soft wings, late hours"), 0x1::string::utf8(b"https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/PNG_transparency_demonstration_1.png/240px-PNG_transparency_demonstration_1.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VMTH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<VMTH>>(0x2::coin_registry::finalize<VMTH>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

