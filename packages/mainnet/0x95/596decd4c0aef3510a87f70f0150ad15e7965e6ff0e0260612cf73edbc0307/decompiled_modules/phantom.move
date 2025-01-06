module 0x95596decd4c0aef3510a87f70f0150ad15e7965e6ff0e0260612cf73edbc0307::phantom {
    struct PHANTOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHANTOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHANTOM>(arg0, 6, b"PHANTOM", b"Phantom on Sui", b"We are pleased to announced our Sui Network integration.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5959_d87251b5af.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHANTOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHANTOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

