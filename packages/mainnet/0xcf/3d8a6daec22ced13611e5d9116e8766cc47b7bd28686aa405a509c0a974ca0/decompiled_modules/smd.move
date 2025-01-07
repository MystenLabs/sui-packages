module 0xcf3d8a6daec22ced13611e5d9116e8766cc47b7bd28686aa405a509c0a974ca0::smd {
    struct SMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMD>(arg0, 6, b"SMD", b"SUI masked Dog", b"The legend of the undersea, masked an dangerous.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimaskedfish_cfbc085803.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

