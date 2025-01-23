module 0xc2e6f2378c0c908c4951e7aafbf48b9b553b328afad7896ddf29857ea1ed802c::trumpdog {
    struct TRUMPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPDOG>(arg0, 6, b"TRUMPDOG", b"Trump Dog For Sui", b"Our president loves dogs, he also likes SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250124_061738_596_3e9c1f0ebd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

