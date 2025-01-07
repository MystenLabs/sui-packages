module 0xff6499ddc4f7cee1b4468bc6335fb1461c1af5a56a37a7a5a323e356071f35ba::sneiro {
    struct SNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEIRO>(arg0, 6, b"SNEIRO", b"First Real Neiro on Sui", x"546865206c6974746c6520736973746572206f6620446f67652e0a4669727374205265616c20244e6569726f206f6e205375692c20636f6d6d756e6974792d6d616e616765642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_5f1440afa8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

