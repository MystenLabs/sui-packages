module 0x1bd43982961fe24e36b8fb02c041b3881d0002875679dae043f3ecda9952b11c::suiton {
    struct SUITON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITON>(arg0, 6, b"SUITON", b"Suiton On Sui", b"The journey of Suiton is begins ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ge_W_t_Pdbs_AA_42_Od_031b7fdd2d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITON>>(v1);
    }

    // decompiled from Move bytecode v6
}

