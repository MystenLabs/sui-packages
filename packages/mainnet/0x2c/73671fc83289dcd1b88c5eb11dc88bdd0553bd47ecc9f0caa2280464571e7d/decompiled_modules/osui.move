module 0x2c73671fc83289dcd1b88c5eb11dc88bdd0553bd47ecc9f0caa2280464571e7d::osui {
    struct OSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSUI>(arg0, 6, b"OSUI", b"Oshawott Sui", b"$OSUI is a decentralized cryptocurrency inspired by the spirit of fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3e4cbc6a246f72de8727ada8a1651999_10f1720fa2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

