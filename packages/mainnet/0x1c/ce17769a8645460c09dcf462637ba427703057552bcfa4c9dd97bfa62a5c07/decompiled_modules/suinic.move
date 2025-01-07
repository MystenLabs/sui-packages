module 0x1cce17769a8645460c09dcf462637ba427703057552bcfa4c9dd97bfa62a5c07::suinic {
    struct SUINIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIC>(arg0, 6, b"SUINIC", b"Suinic", x"5355494e4943206973206e6f74206a7573742061206d656d65636f696e2e20576520617265206865726520666f7220746865204d4f4f4e0a0a4469766520696e746f20746865206465657020776174657273206f6620245355494e494320776865726520657665727920627562626c65206973206120676f6c6420636f696e20696e20746865206f6365616e2e204a6f696e20757320616e642074616b6520746f2074686520736b69657321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035490_bce29b6fdd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

