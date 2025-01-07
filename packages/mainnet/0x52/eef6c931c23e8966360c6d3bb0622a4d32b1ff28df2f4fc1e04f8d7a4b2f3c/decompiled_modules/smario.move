module 0x52eef6c931c23e8966360c6d3bb0622a4d32b1ff28df2f4fc1e04f8d7a4b2f3c::smario {
    struct SMARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMARIO>(arg0, 6, b"SMARIO", b"SUIPERMARIO", b"SUIPER MARIO BROS ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3588_e64c904bdb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

