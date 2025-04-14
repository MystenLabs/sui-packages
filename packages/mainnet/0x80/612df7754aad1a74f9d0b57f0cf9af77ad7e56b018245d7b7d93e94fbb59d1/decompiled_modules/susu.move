module 0x80612df7754aad1a74f9d0b57f0cf9af77ad7e56b018245d7b7d93e94fbb59d1::susu {
    struct SUSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSU>(arg0, 6, b"SUSU", b"Suie Suoke", x"537569652053756f6b652069732061206d656d652d706f776572656420636f6d6d756e69747920746f6b656e20696e667573656420776974682053756920656e657267792e0a497420626c656e6473206368616f732c207374796c652c20616e64207468617420756e6578706c61696e61626c652053756f6b65207370697269742e0a0a596f7520646f6e74206e65656420746f20756e6465727374616e642069742e0a596f75206a757374206e65656420746f206665656c2069742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NA_vtelen_terv_2_f92d9fa364.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

