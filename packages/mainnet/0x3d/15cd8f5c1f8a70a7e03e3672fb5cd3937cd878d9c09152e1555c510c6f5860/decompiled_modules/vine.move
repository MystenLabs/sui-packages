module 0x3d15cd8f5c1f8a70a7e03e3672fb5cd3937cd878d9c09152e1555c510c6f5860::vine {
    struct VINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINE>(arg0, 6, b"VINE", b"VINE COIN ON SUI", x"446f20697420666f72207468652056696e652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2025_01_23_a_las_14_03_37_973832936a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

