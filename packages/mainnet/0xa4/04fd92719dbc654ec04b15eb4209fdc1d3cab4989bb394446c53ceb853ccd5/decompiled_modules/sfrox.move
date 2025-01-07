module 0xa404fd92719dbc654ec04b15eb4209fdc1d3cab4989bb394446c53ceb853ccd5::sfrox {
    struct SFROX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFROX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFROX>(arg0, 6, b"SFrox", b"SuiFrox", b"The Frox on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_14_14_37_02_20784a8cd1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFROX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFROX>>(v1);
    }

    // decompiled from Move bytecode v6
}

