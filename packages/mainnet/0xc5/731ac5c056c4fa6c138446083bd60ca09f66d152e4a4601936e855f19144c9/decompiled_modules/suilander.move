module 0xc5731ac5c056c4fa6c138446083bd60ca09f66d152e4a4601936e855f19144c9::suilander {
    struct SUILANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILANDER>(arg0, 6, b"SUILANDER", b"Suilander", b"The hero Sui deserves!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2ec560b6_3275_43a1_bd96_8e2e8f2a14fc_edited_edited_1_198bb4e197.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILANDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILANDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

