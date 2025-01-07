module 0x527139426447dafe25fc7ce1a81161dcefc413a81d33185d7daf9cecd7c16263::rud {
    struct RUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUD>(arg0, 6, b"Rud", b"Rudog", x"5275646f6c70682063616c6c656420696e207369636b2c20736f20746865792073656e74206d652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/93437431_9_DA_3_4903_BDAC_E7357_E7_F5_AEF_a73573f0e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

