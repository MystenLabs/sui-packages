module 0xbe2aa4634b4d6f0c6e290e7a9d6e3a8f2ea2689914734cb2a5760647370cb18c::shart {
    struct SHART has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHART>(arg0, 6, b"Shart", b"Shartcoin", b"The wettest fart on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2784_ab5e23d887.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHART>>(v1);
    }

    // decompiled from Move bytecode v6
}

