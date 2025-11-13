module 0x221b046d767abec8317a194955ea4dd340986091725ae1eebbf12ad704ee0a0e::PIKA {
    struct PIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PIKA>(arg0, 9, 0x1::string::utf8(b"PIKA"), 0x1::string::utf8(b"Pikamon"), 0x1::string::utf8(b"A fun, Pokemon-inspired meme token with fixed supply for collectors and enthusiasts on the Sui blockchain."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PIKA>>(0x2::coin_registry::finalize<PIKA>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PIKA>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKA>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKA>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

