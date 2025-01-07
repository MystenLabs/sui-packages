module 0x7f126ca1232130307196f7e95dc3cc46cac9885b6a87a0856eea1fa8fc59c7af::suipup {
    struct SUIPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUP>(arg0, 6, b"SUIPUP", b"SUI PUP", b"BARK BARK BARK BARK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xd658a5a26528b4ab986bb9aa2c89913c11b79fc56b21ac823376fe2aa7c9d785_spup_spup_2d80d41d42.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

