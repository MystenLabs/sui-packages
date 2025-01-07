module 0xe4aadb9c279e8761446735f4594b86fcf3bdd4a050c5c8ccdc4157655ab7ac2d::yacat {
    struct YACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YACAT>(arg0, 6, b"YACAT", b"Yakuza Cat", x"41206669657263652066656c696e6520776974682061207368617270207375697420616e642061206d7973746572696f757320706173742c207468697320746f6b656e20636f6d62696e65732074686520656c6567616e6365206f6620612063617420776974682074686520756e646572776f726c64277320616c6c7572652e20456d6272616365207468652070617261646f78206f6620637574656e65737320616e642064616e67657220696e207468652063727970746f20776f726c642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yakuzacat_c2a174c2b1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

