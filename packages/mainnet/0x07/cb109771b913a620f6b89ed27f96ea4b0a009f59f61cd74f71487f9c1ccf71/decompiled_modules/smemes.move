module 0x7cb109771b913a620f6b89ed27f96ea4b0a009f59f61cd74f71487f9c1ccf71::smemes {
    struct SMEMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMEMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMEMES>(arg0, 6, b"SMEMES", b"SQUIDMEMES", x"5371756964204d656d657320697320746865206d6f737420706f70756c61722074762073657269657320696e2074686520686973746f7279206f66204e6574666c69782e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7181_244707ad69.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMEMES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMEMES>>(v1);
    }

    // decompiled from Move bytecode v6
}

