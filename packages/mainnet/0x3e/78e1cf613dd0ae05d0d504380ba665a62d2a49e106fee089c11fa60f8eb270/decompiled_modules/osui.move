module 0x3e78e1cf613dd0ae05d0d504380ba665a62d2a49e106fee089c11fa60f8eb270::osui {
    struct OSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSUI>(arg0, 6, b"OSUI", b"Oshawott Sui", b"Meet Oshawott - Meme in sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3e4cbc6a246f72de8727ada8a1651999_654f18a84f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

