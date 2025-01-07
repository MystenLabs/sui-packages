module 0x4f70c77e784be4bd9089e8f2212dc0aef6f2c0b33b4dc6bdf62976a53fad4547::lman {
    struct LMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMAN>(arg0, 6, b"Lman", b"luxury Man", b"luxury lives on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdfsdfsdfsdfsd_75284e740c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

