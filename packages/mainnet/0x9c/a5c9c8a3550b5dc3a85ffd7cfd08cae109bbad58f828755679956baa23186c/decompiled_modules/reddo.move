module 0x9ca5c9c8a3550b5dc3a85ffd7cfd08cae109bbad58f828755679956baa23186c::reddo {
    struct REDDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDDO>(arg0, 6, b"REDDO", b"REDDO TOKEN", x"57656c636f6d6520746f2074686520526564646f20204120626f6c6420616e64207370696379206e6577206d656d6520636f696e20626f726e20696e20746865206865617274206f66204e6577204d657869636f2c20555341200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_3_6e96d226ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

